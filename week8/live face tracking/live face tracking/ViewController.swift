//
//  ViewController.swift
//  live face tracking
//
//  Created by 何若琪 on 11/2/23.
//

import UIKit
import SceneKit
import ARKit



    class ViewController: UIViewController {
        
        @IBOutlet weak var statusLabel: UILabel!
        @IBOutlet weak var sceneView: ARSCNView!
        @IBOutlet weak var glassesView: UIView!
        @IBOutlet weak var collectionView: UICollectionView!
        @IBOutlet weak var calibrationView: UIView!
        @IBOutlet weak var calibrationTransparentView: UIView!
        @IBOutlet weak var collectionBottomConstraint: NSLayoutConstraint!
        @IBOutlet weak var calibrationBottomConstraint: NSLayoutConstraint!
        @IBOutlet weak var collectionButton: UIButton!
        @IBOutlet weak var calibrationButton: UIButton!
    
        
     
        
        override func viewDidLoad() {
            super.viewDidLoad()
            guard ARFaceTrackingConfiguration.isSupported else {
            statusLabel.text = "Face tracking is not supported on this device"
            return
            }
            sceneView.delegate = self
          
        }
        override func viewWillAppear(_ animated: Bool) {
             super.viewWillAppear(animated)
             
             let configuration = ARFaceTrackingConfiguration()
             sceneView.session.run(configuration)
         }
         
         override func viewWillDisappear(_ animated: Bool) {
             super.viewWillDisappear(animated)
             
             sceneView.session.pause()
         }
         
      
      
    }

    extension ViewController: ARSCNViewDelegate {
        func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
            guard let device = sceneView.device else {
                return nil
            }
            
            let faceGeometry = ARSCNFaceGeometry(device: device)
            let faceNode = SCNNode(geometry: faceGeometry)
            faceNode.geometry?.firstMaterial?.transparency = 0
            
           
            return faceNode
        }
        
        func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
            guard let faceAnchor = anchor as? ARFaceAnchor, let faceGeometry = node.geometry as? ARSCNFaceGeometry else {
                return
            }
            
            faceGeometry.update(from: faceAnchor.geometry)
        }
    }

    
