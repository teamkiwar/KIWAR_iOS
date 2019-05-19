//
//  CatchGameViewController.swift
//  KiWar
//
//  Created by 장용범 on 05/05/2019.
//  Copyright © 2019 장용범. All rights reserved.
//

import UIKit
import ARKit

class CatchGameViewController: UIViewController {

    @IBOutlet weak var sceneView: ARSCNView!
    let configuration = ARWorldTrackingConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
        sceneView.debugOptions = [.showWorldOrigin]
        sceneView.session.run(configuration)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        sceneView.addGestureRecognizer(tap)
        addNode(name: "Buffalo", range: -1)
        addNode(name: "Lion", range: 2)
        addNode(name: "Mouse", range: 5)

        
    }
    
    
    
    func addNode(name: String, range: CGFloat){
        let rootScene = SCNScene(named: "art.scnassets/"+name+"/"+name+".scn")
        let node = rootScene?.rootNode.childNode(withName: name, recursively: false)
        
        node?.position = SCNVector3(range,-3,-5)
        sceneView.scene.rootNode.addChildNode(node!)
    }
    
    func animateNode(node: SCNNode){
        let spin = CABasicAnimation(keyPath: "position")
        spin.fromValue = node.presentation.position
        spin.toValue = SCNVector3(0, 0, node.presentation.position.z - 1)
        spin.duration = 1
        spin.autoreverses = true
        node.addAnimation(spin, forKey: "position")
    }
   
    @objc func handleTap(sender: UITapGestureRecognizer){
        let sceneViewTappedOn = sender.view as! SCNView
        let touchCoordinates = sender.location(in: sceneViewTappedOn)
        let hitTest = sceneViewTappedOn.hitTest(touchCoordinates)
        
        if hitTest.isEmpty{
            
        }else{
            let results = hitTest.first!
            let node = results.node
            self.setQuiz(name: node.name!)
//            if node.animationKeys.isEmpty {
//                self.animateNode(node: node)
//            }
        }
        
    }
    

}

extension CatchGameViewController{
    func setQuiz(name: String){
        let alert = UIAlertController(title: "이 동물의 이름은 무엇일까요?", message: nil, preferredStyle: .actionSheet)
        var answerMean = ""
        
        var animalArray = animals
        var problemArray: [String] = []
        
        for animal in animalArray{
            if animal.name == name{
                answerMean = animal.mean
                problemArray.append(answerMean)
            }
        }
        
        animalArray.shuffle()
        for i in 0..<3{
            if animalArray[i].name != name{
                problemArray.append(animalArray[i].mean)
            }
        }
        
        problemArray.shuffle()
        
        for i in 0..<problemArray.count{
            var action : UIAlertAction? = nil
            if problemArray[i] == answerMean{
                action = UIAlertAction(title: problemArray[i], style: .default, handler: { (action) in
                    let alert = UIAlertController(title: nil, message: "짝짝짝! 정답입니다!", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { (action) in
                        self.sceneView.scene.rootNode.childNode(withName: name, recursively: false)?.removeFromParentNode()
                    }))
                    self.present(alert, animated: true, completion: nil)
                    
                })
                alert.addAction(action!)
            }else{
                action = UIAlertAction(title: problemArray[i], style: .default, handler: { action in
                    let alert = UIAlertController(title: nil, message: "다시 한번 생각해보세요.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                })
                alert.addAction(action!)
            }
            
        }

        
        self.navigationController?.present(alert, animated: true, completion: nil)

    }
}
