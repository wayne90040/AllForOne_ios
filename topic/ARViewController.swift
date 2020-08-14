//
//  ARViewController.swift
//  topic
//
//  Created by 許維倫 on 2019/10/15.
//  Copyright © 2019 許維倫. All rights reserved.
//

import UIKit
import ARKit
import SceneKit

class ARViewController: UIViewController{

    @IBOutlet weak var sceneView: ARSCNView! // ARView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // sceneView.delegate = self as! ARSCNViewDelegate
        configureLighting()
        addhiphopDance()
    }
    
    // view開啟時開始追蹤
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        sceneView.session.run(configuration)
        
    }
    
    // view關閉時停止追蹤
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        sceneView.session.pause()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func configureLighting() {
        sceneView.autoenablesDefaultLighting = true
        sceneView.automaticallyUpdatesLighting = true
    }
    
    
    func addhiphopDance(x: Float = 0, y: Float = -10, z: Float = -10) {
        guard let hiphopScene = SCNScene(named: "art.scnassets/HipHop/HipHop.dae") else { return }
        let hiphopNode = SCNNode()
        let hiphopSceneChildNodes = hiphopScene.rootNode.childNodes
        
        for childNode in hiphopSceneChildNodes {
            hiphopNode.addChildNode(childNode)
        }
        
        hiphopNode.position = SCNVector3(x, y, z)
        hiphopNode.scale = SCNVector3(0.05, 0.05, 0.05)
        sceneView.scene.rootNode.addChildNode(hiphopNode)
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

