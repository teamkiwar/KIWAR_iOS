//
//  FindGameViewController.swift
//  KiWar
//
//  Created by 장용범 on 05/05/2019.
//  Copyright © 2019 장용범. All rights reserved.
//

import UIKit
import ARKit

class FindGameViewController: UIViewController {

    @IBOutlet weak var sceneView: ARSCNView!
    let configuration = ARWorldTrackingConfiguration()
    var shuffleAnimals = animals
    var answer : Word?
    @IBOutlet weak var answerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
        sceneView.session.run(configuration)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        sceneView.addGestureRecognizer(tap)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        initializeQuiz()
    }
    
    func initializeQuiz(){
        shuffleAnimals.shuffle()
        let random = Int.random(in: 0...2)
        answer = shuffleAnimals[random]
        answerLabel.text = answer?.mean
        print(shuffleAnimals)
        addNode(name: shuffleAnimals[0].name, range: -3)
        addNode(name: shuffleAnimals[1].name, range: 3)
        addNode(name: shuffleAnimals[2].name, range: 9)
    }
    
    func addNode(name: String, range: CGFloat){
        let rootScene = SCNScene(named: "art.scnassets/\(name)/\(name).scn")
        let node = rootScene?.rootNode.childNode(withName: name, recursively: false)
        
        node?.position = SCNVector3(range,-4,-8)
        sceneView.scene.rootNode.addChildNode(node!)
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

extension FindGameViewController{
    func setQuiz(name: String){
        var answerMean = ""
        for animal in shuffleAnimals{
            if name == animal.name{
                answerMean = animal.mean
            }
        }
        let alert = UIAlertController(title: "이 동물이 \(answer!.mean) 인가요?", message: nil, preferredStyle: .alert)
        let yes = UIAlertAction(title: "네!", style: .default) { action in
            if answerMean == self.answer?.mean{
                let alert = UIAlertController(title: nil, message: "짝짝짝! 정답입니다!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { (action) in
                    self.navigationController?.popViewController(animated: true)
                }))
                self.present(alert, animated: true, completion: nil)
            }else{
                let alert = UIAlertController(title: nil, message: "다시 한번 생각해보세요.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        let no = UIAlertAction(title: "아니요!", style: .cancel, handler: nil)
        alert.addAction(yes)
        alert.addAction(no)
        
        self.navigationController?.present(alert, animated: true, completion: nil)
        
    }
    
}

