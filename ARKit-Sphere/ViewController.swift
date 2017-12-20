//
//  ViewController.swift
//  ARKit-Sphere
//
//  Created by Luis Puentes on 12/18/17.
//  Copyright © 2017 LuisPuentes. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    var globe: SCNNode!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        let scene = SCNScene()
        let position = SCNVector3(0, 0, -0.3)
        globe = createSphere(at: position)
        scene.rootNode.addChildNode(globe)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(spinGlobe))
        sceneView.addGestureRecognizer(tap)
        
        // Set the scene to the view
        sceneView.scene = scene
    }
    
    func createSphere(at position: SCNVector3) -> SCNNode {
        let sphere = SCNSphere(radius: 0.1)
        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named: "art.scnassets/earth.jpg")
        sphere.firstMaterial = material
        let sphereMode = SCNNode(geometry: sphere)
        sphereMode.position = position
        
        return sphereMode
    }
    
    @objc func spinGlobe() {
        let action = SCNAction.rotate(by: 360 * CGFloat((Double.pi)/180), around: SCNVector3(0, 1, 0), duration: 12)
        let repeatAction = SCNAction.repeatForever(action)
        
        globe.runAction(repeatAction)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
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
