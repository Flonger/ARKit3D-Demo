//
//  ViewController.swift
//  ARDemo1
//
//  Created by 薛飞龙 on 2017/6/10.
//  Copyright © 2017年 薛飞龙. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        let scene = SCNScene(named: "art.scnassets/ship.scn")!
        
        // Set the scene to the view
        sceneView.scene = scene
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingSessionConfiguration()
        
        // Run the view's session
        sceneView.session.run(configuration)
        
        let topGesture = UITapGestureRecognizer(target:self, action:#selector(ViewController.handleTap(gestureRecognizer:)))
        
        view.addGestureRecognizer(topGesture)
        
    }
    
    @objc
    func handleTap(gestureRecognizer:UITapGestureRecognizer)  {
        guard let currentFrame = sceneView.session.currentFrame else {
            return
        }
        
        let imagePlan = SCNPlane(width: sceneView.bounds.width/6000, height: sceneView.bounds.height/6000)
        
        imagePlan.firstMaterial?.diffuse.contents = sceneView.snapshot()
        imagePlan.firstMaterial?.lightingModel = .constant
        
        let planNode = SCNNode(geometry: imagePlan)
        sceneView.scene.rootNode.addChildNode(planNode)
        
        var translate = matrix_identity_float4x4
        translate.columns.3.z = -0.1 // 10公分
        planNode.simdTransform = matrix_multiply(currentFrame.camera.transform, translate)
        
        
        
    }
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
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
