//
//  ViewController.swift
//  KiWar
//
//  Created by 장용범 on 17/03/2019.
//  Copyright © 2019 장용범. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
import KakaoNewtoneSpeech

class ViewController: UIViewController, ARSCNViewDelegate, ARSessionDelegate {
    
    @IBOutlet var sceneView: ARSCNView!
    var name: String = ""
    var mean: String = ""
    let speechClient = MTSpeechRecognizerClient(config: [SpeechRecognizerConfigKeyServiceType: SpeechRecognizerServiceTypeWord])
    
    var node: SCNNode?
    var currentAngleY: Float = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.delegate = self
        sceneView.showsStatistics = true
        
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(didPinch(_:)))
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(didPan(_:)))
        sceneView.addGestureRecognizer(pinchGesture)
        sceneView.addGestureRecognizer(panGesture)
        speechClient?.delegate = self
        
        // Create a new scene
        if let scene = SCNScene(named: "art.scnassets/\(name)/\(name).scn"){
            node = scene.rootNode.childNode(withName: name, recursively: false)
            node!.position = SCNVector3(0,-3,-6)
            sceneView.scene.rootNode.addChildNode(node!)
            
        }else{
            
        }
        
    }
    
    @objc func didPinch(_ gesture: UIPinchGestureRecognizer) {
        guard let _ = node else { return }
        var originalScale = node?.scale
        
        switch gesture.state {
        case .began:
            originalScale = node?.scale
            gesture.scale = CGFloat((node?.scale.x)!)
        case .changed:
            guard var newScale = originalScale else { return }
            if gesture.scale < 0.5{ newScale = SCNVector3(x: 0.5, y: 0.5, z: 0.5) }else if gesture.scale > 2{
                newScale = SCNVector3(2, 2, 2)
            }else{
                newScale = SCNVector3(gesture.scale, gesture.scale, gesture.scale)
            }
            node?.scale = newScale
        case .ended:
            guard var newScale = originalScale else { return }
            if gesture.scale < 0.5{ newScale = SCNVector3(x: 0.5, y: 0.5, z: 0.5) }else if gesture.scale > 2{
                newScale = SCNVector3(2, 2, 2)
            }else{
                newScale = SCNVector3(gesture.scale, gesture.scale, gesture.scale)
            }
            node?.scale = newScale
            gesture.scale = CGFloat((node?.scale.x)!)
        default:
            gesture.scale = 1.0
            originalScale = nil
        }
    }
    
    @objc func didPan(_ gesture: UIPanGestureRecognizer) {
        guard let _ = node else { return }
        let translation = gesture.translation(in: gesture.view)
        var newAngleY = (Float)(translation.x)*(Float)(Double.pi)/180.0
        
        newAngleY += currentAngleY
        node?.eulerAngles.y = newAngleY
        
        if gesture.state == .ended{
            currentAngleY = newAngleY
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("\(name), \(mean)")
        
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    @IBAction func pronunciation(_ sender: Any) {
        
        print("발음!!")
        
        
        speechClient?.startRecording()
        
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}

extension ViewController: MTSpeechRecognizerDelegate{
    func onReady() {
        
    }
    
    func onBeginningOfSpeech() {
        
    }
    
    func onEndOfSpeech() {
        print("END!!!")
    }
    
    func onError(_ errorCode: MTSpeechRecognizerError, message: String!) {
        print(message)
    }
    
    func onPartialResult(_ partialResult: String!) {
        print("-----------------onPartial----------------")
        print("partial: \(partialResult)")
    }
    
    func onResults(_ results: [Any]!, confidences: [Any]!, marked: Bool) {
        print("------------onResults----------------")
        print(results)
        print("--------------------------------------")
        
        //        if results == "results[0]: \(mean)"{
        //            print("정답!!!!")
        //        }else{
        //            print("틀림!!!!")
        //        }
        //
    }
    
    func onAudioLevel(_ audioLevel: Float) {
        
    }
    
    func onFinished() {
        
    }
    
    
}


