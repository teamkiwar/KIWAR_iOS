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

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    var name: String = ""
    var mean: String = ""
    let speechClient = MTSpeechRecognizerClient(config: [SpeechRecognizerConfigKeyServiceType: SpeechRecognizerServiceTypeWord])
    var speechView = MTSpeechRecognizerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.delegate = self
        sceneView.showsStatistics = true
        
        speechClient?.delegate = self
        speechView.delegate = self
        speechView.frame = self.view.frame
        speechView = MTSpeechRecognizerView(frame: self.view.frame, withConfig: [SpeechRecognizerConfigKeyApiKey: "276b121c823e351749a027ba4d01d052"])
        
        // Create a new scene
        if let scene = SCNScene(named: "art.scnassets/\(name)/\(name).scn"){
            if let node = scene.rootNode.childNode(withName: name, recursively: false){
                node.position = SCNVector3(0,-3,-6)
                sceneView.scene.rootNode.addChildNode(node)
            }
        }else{
            
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
        view.addSubview(speechView)
        speechView.show()
        
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

extension ViewController: MTSpeechRecognizerDelegate, MTSpeechRecognizerViewDelegate{
    func onReady() {
        
    }
    
    func onBeginningOfSpeech() {
        
    }
    
    func onEndOfSpeech() {
        
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
