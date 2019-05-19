//
//  DecorateViewController.swift
//  KiWar
//
//  Created by 장용범 on 17/03/2019.
//  Copyright © 2019 장용범. All rights reserved.
//

import UIKit
import ARKit
import ColorSlider

class DecoViewController: UIViewController, ARSCNViewDelegate, ARSessionDelegate, UIGestureRecognizerDelegate {

    @IBOutlet weak var drawButton: UIButton!
    @IBOutlet weak var sceneView: ARSCNView!
    var drawColor: UIColor = UIColor.white
    
    let configuration = ARWorldTrackingConfiguration()
    
    var object: SCNNode! = {
        guard let scene = SCNScene(named: "art.scnassets/dog/Mesh_Beagle.scn"),
            let node = scene.rootNode.childNode(withName: "dog", recursively: false) else {
                print("fucckkkk")
                return SCNNode() }
        let scaleFactor  = 0.004
        node.scale = SCNVector3(scaleFactor, scaleFactor, scaleFactor)
//        node.eulerAngles.x += -.pi / 2
        return node
    }()
    
    var currentAngleY: Float = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        let colorSlider = ColorSlider(orientation: .vertical, previewSide: .left)
        colorSlider.frame = CGRect(x: view.frame.maxX-50, y: view.center.y-70, width: 20, height: 150)
        sceneView.addSubview(colorSlider)
        
        colorSlider.addTarget(self, action: #selector(changedColor(_:)), for: .valueChanged)
        
        sceneView.delegate  = self
        //sceneView.debugOptions = [.showWorldOrigin,.showFeaturePoints]
        sceneView.showsStatistics = true

        sceneView.session.run(configuration)
        
        
        
    }
    
    func setGesture(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTap(_:)))
        sceneView.addGestureRecognizer(tapGesture)
        
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(didPinch(_:)))
        sceneView.addGestureRecognizer(pinchGesture)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(didPan(_:)))
        panGesture.delegate = self
        sceneView.addGestureRecognizer(panGesture)
    }
    
    @objc func didTap(_ gesture: UIPanGestureRecognizer){
//        guard let _ = object else { return }
//
//        let tapLocation = gesture.location(in: sceneView)
//        let results = sceneView.hitTest(tapLocation, types: .featurePoint)
//
//        if let result = results.first {
//            let translation = result.worldTransform.translation
//            object.position = SCNVector3Make(translation.x, translation.y, translation.z)
//            sceneView.scene.rootNode.addChildNode(object)
//        }
    }
    
    @objc func didPinch(_ gesture: UIPinchGestureRecognizer) {
        print("didPinch")
        guard let _ = object else { return }
        var originalScale = object?.scale
        
        switch gesture.state {
        case .began:
            originalScale = object?.scale
            gesture.scale = CGFloat((object?.scale.x)!)
        case .changed:
            guard var newScale = originalScale else { return }
            if gesture.scale < 0.5{ newScale = SCNVector3(x: 0.5, y: 0.5, z: 0.5) }else if gesture.scale > 2{
                newScale = SCNVector3(2, 2, 2)
            }else{
                newScale = SCNVector3(gesture.scale, gesture.scale, gesture.scale)
            }
            object?.scale = newScale
        case .ended:
            guard var newScale = originalScale else { return }
            if gesture.scale < 0.5{ newScale = SCNVector3(x: 0.5, y: 0.5, z: 0.5) }else if gesture.scale > 2{
                newScale = SCNVector3(2, 2, 2)
            }else{
                newScale = SCNVector3(gesture.scale, gesture.scale, gesture.scale)
            }
            object?.scale = newScale
            gesture.scale = CGFloat((object?.scale.x)!)
        default:
            gesture.scale = 1.0
            originalScale = nil
        }
    }
    
    @objc func didPan(_ gesture: UIPanGestureRecognizer) {
        print("didpan")
        guard let _ = object else { return }
        let translation = gesture.translation(in: gesture.view)
        var newAngleY = (Float)(translation.x)*(Float)(Double.pi)/180.0
        
        newAngleY += currentAngleY
        object?.eulerAngles.y = newAngleY
        
        if gesture.state == .ended{
            currentAngleY = newAngleY
        }
    }
    
    @objc func changedColor(_ slider: ColorSlider) {
        let selectedColor = slider.color
        drawColor = selectedColor
    }
    
    func renderer(_ renderer: SCNSceneRenderer, willRenderScene scene: SCNScene, atTime time: TimeInterval) {
        guard let pointOfView = sceneView.pointOfView else {return} // current location of camera
        let transform = pointOfView.transform
        let orientation = SCNVector3(-transform.m31,-transform.m32,-transform.m33)
        let location = SCNVector3(transform.m41,transform.m42,transform.m43)
        
        let currentPositionOfCamera = orientation + location
        
        DispatchQueue.main.async {
            if self.drawButton.isHighlighted{
                
                let sphereNode = SCNNode(geometry: SCNSphere(radius: 0.02))
                sphereNode.geometry?.firstMaterial?.diffuse.contents = self.drawColor
                sphereNode.position = currentPositionOfCamera
                self.sceneView.scene.rootNode.addChildNode(sphereNode)
                
                print("draw pressed")
            }else{
                //print("else")
                let pointer = SCNNode(geometry: SCNSphere(radius: 0.01))
                pointer.name = "pointer"
                pointer.geometry?.firstMaterial?.diffuse.contents = self.drawColor
                pointer.position = currentPositionOfCamera
                
                self.sceneView.scene.rootNode.enumerateChildNodes{ (node, _) in
                    if node.name == "pointer"{
                        node.removeFromParentNode()
                    }
                }
                
                self.sceneView.scene.rootNode.addChildNode(pointer)
                
            }
        }
        
        
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        sceneView.scene.rootNode.addChildNode(object)
        node.addChildNode(object)
    }

    @IBAction func screenShot(_ sender: Any) {
        let snapShot = self.sceneView.snapshot()
        UIImageWriteToSavedPhotosAlbum(snapShot, nil, nil, nil)
        
        let alert = UIAlertController(title: "사진 저장", message: "스크린샷을 저장했습니다.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func addObject(_ sender: Any) {
        guard let _ = object else { return }
        
        let tapLocation = CGPoint(x: 0, y: 0)
        let results = sceneView.hitTest(tapLocation, types: .featurePoint)
        
        if let result = results.first {
            let translation = result.worldTransform.translation
            object.position = SCNVector3Make(0, 0.1, -0.4)
            sceneView.scene.rootNode.addChildNode(object)
        }
    }
    
}

func +(left: SCNVector3, right: SCNVector3) -> SCNVector3{
    return SCNVector3Make(left.x + right.x, left.y + right.y, left.z + right.z)
}


extension float4x4 {
    var translation: float3 {
        let translation = self.columns.3
        return float3(translation.x, translation.y, translation.z)
    }
}
