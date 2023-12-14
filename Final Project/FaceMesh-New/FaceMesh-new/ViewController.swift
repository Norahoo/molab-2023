//
//  ViewController.swift
//  True Depth
//
//  Created by Sai Kambampati on 2/23/19.
//  Copyright © 2019 AppCoda. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    @IBOutlet weak var faceLabel: UILabel!
    @IBOutlet weak var labelView: UIView!
    var analysis = ""
    var reportChange: (() -> Void)!
    var smileModelNode: SCNNode?
    private var lastPanLocation: CGPoint?
    private var flowerScale: Float = 1.0
    var pepperModelNode: SCNNode?
                      
    
    @IBAction func changeColorButtonTapped(_ sender: UIButton) {
        // Generate random color
        let randomColor = UIColor(
            red: CGFloat.random(in: 0.0...1.0),
            green: CGFloat.random(in: 0.0...1.0),
            blue: CGFloat.random(in: 0.0...1.0),
            alpha: 1.0
        )

        // Perform your 3D interaction here
        let tapLocation = CGPoint(x: sceneView.bounds.midX, y: sceneView.bounds.midY)
        let hitTestResults = sceneView.hitTest(tapLocation)

        guard let firstHit = hitTestResults.first else {
            return
        }

        // Use the SCNNode directly without conditional casting
        let tappedNode = firstHit.node

        // Change the color of the 3D model to the randomly generated color
        tappedNode.geometry?.firstMaterial?.diffuse.contents = randomColor
    }

    
    

    override func viewDidLoad() {
        print("ViewController viewDidLoad")
        super.viewDidLoad()
        
        labelView.layer.cornerRadius = 10
        
        sceneView.delegate = self
        sceneView.showsStatistics = true
        // Load the flower model
        loadFlowerModel()
        // Load the banana model
        loadBananaModel()
        guard ARFaceTrackingConfiguration.isSupported else {
            print("Face tracking is not supported on this device")
            return
        }
        
        // Disable UIKit label in Main.storyboard
        labelView.isHidden = true
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        self.view.addGestureRecognizer(panGesture)

        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch(_:)))
        self.view.addGestureRecognizer(pinchGesture)
    }
    @objc private func handlePan(_ gesture: UIPanGestureRecognizer) {
           guard let smileModelNode = smileModelNode else { return }

           switch gesture.state {
           case .began:
               lastPanLocation = gesture.location(in: self.view)

           case .changed:
               guard let lastPanLocation = lastPanLocation else { return }
               let currentPanLocation = gesture.location(in: self.view)
               let deltaX = currentPanLocation.x - lastPanLocation.x
               let deltaY = currentPanLocation.y - lastPanLocation.y

               smileModelNode.position.x += Float(deltaX) / 100   // Adjust the scale factor based on your needs
               smileModelNode.position.y -= Float(deltaY) / 100

               self.lastPanLocation = currentPanLocation

           case .ended, .cancelled:
               lastPanLocation = nil

           default:
               break
           }
       }

       @objc private func handlePinch(_ gesture: UIPinchGestureRecognizer) {
           guard let smileModelNode = smileModelNode else { return }

           switch gesture.state {
           case .changed, .ended:
               flowerScale *= Float(gesture.scale)
               let scale = SCNVector3(flowerScale, flowerScale, flowerScale)

               smileModelNode.scale = scale

               gesture.scale = 1.0

           default:
               break
           }
       }
    var bananaModelNode: SCNNode?

    func loadBananaModel() {
        if let modelScene = SCNScene(named: "banana.scn") { // Update the file name
            guard let modelNode = modelScene.rootNode.childNode(withName: "Cube", recursively: true) else {
                print("Error: Model node not found in the banana scene.")
                return
            }

            bananaModelNode = modelNode.clone()
            
            // Apply rotation transformation to match ARKit's coordinate system
            let rotationMatrix = simd_float4x4(SCNMatrix4MakeRotation(-Float.pi / 2.0, 0, 1, 0))
            bananaModelNode?.simdTransform = rotationMatrix
            
            // Optionally, adjust the position or scale of the loaded model
            bananaModelNode?.scale = SCNVector3(1, 1, 1)
        } else {
            print("Error: Failed to load the banana model scene.")
        }
    }

    // Call loadBananaModel() in your viewDidLoad or a similar place

    func loadFlowerModel() {
        if let modelScene = SCNScene(named: "flower.scn") { // Update the file extension
            guard let modelNode = modelScene.rootNode.childNode(withName: "flower", recursively: true) else {
                print("Error: Model node not found in the scene.")
                return
            }

            smileModelNode = modelNode.clone()

            // Optionally, adjust the position or scale of the loaded model
            smileModelNode?.scale = SCNVector3(1, 1, 1)
        } else {
            print("Error: Failed to load the flower model scene.")
        }
    }
    
    func loadPepperModel() {
        if let modelScene = SCNScene(named: "pepper.scn") { // Update the file name
            guard let modelNode = modelScene.rootNode.childNode(withName: "RedPepper", recursively: true) else {
                print("Error: Model node not found in the pepper scene.")
                return
            }

            pepperModelNode = modelNode.clone()

            // Apply rotation transformation to match ARKit's coordinate system
            let rotationMatrix = simd_float4x4(SCNMatrix4MakeRotation(-Float.pi / 2.0, 0, 1, 0))
            pepperModelNode?.simdTransform = rotationMatrix
            pepperModelNode?.position = SCNVector3(x: 0, y: 0, z: -15) // Adjust as needed


            // Optionally, adjust the position or scale of the loaded model
            pepperModelNode?.scale = SCNVector3(1, 1, 1)
        } else {
            print("Error: Failed to load the pepper model scene.")
        }
    }

    
    override func viewWillAppear(_ animated: Bool) {
        print("ViewController viewWillAppear")

        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARFaceTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("ViewController viewWillDisappear")

        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    // MARK: - ARSCNViewDelegate
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let faceMesh = ARSCNFaceGeometry(device: sceneView.device!)
        let node = SCNNode(geometry: faceMesh)
        
        node.geometry?.firstMaterial?.fillMode = .lines
        
        return node
    }

    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
            if let faceAnchor = anchor as? ARFaceAnchor, let faceGeometry = node.geometry as? ARSCNFaceGeometry {
                faceGeometry.update(from: faceAnchor.geometry)
                expression(anchor: faceAnchor)
                
                DispatchQueue.main.async {
                    // Disable UIKit label in Main.storyboard
                    // self.faceLabel.text = self.analysis
                    // Report changes to SwiftUI code
                    self.reportChange()
                    self.updateModel(for: faceAnchor, on: node)
                    
                }
                
            }
        }

    
    func updateModel(for faceAnchor: ARFaceAnchor, on node: SCNNode) {
        let isSmiling = ((faceAnchor.blendShapes[.mouthSmileLeft]?.decimalValue ?? 0.0) +
                         (faceAnchor.blendShapes[.mouthSmileRight]?.decimalValue ?? 0.0)) > 0.9
        let isCheekPuffed = (faceAnchor.blendShapes[.cheekPuff]?.decimalValue ?? 0.0) > 0.1
        let isJawOpen = (faceAnchor.blendShapes[.jawOpen]?.decimalValue ?? 0.0) > 0.9

        if isSmiling {
            // Show the flower model when smiling
            if let smileModelNode = smileModelNode {
                if !sceneView.scene.rootNode.childNodes.contains(smileModelNode) {
                    sceneView.scene.rootNode.addChildNode(smileModelNode)
                }

                // Get the orientation of the face
                let orientation = faceAnchor.transform

                // Create a rotation matrix for a 45-degree rotation around the X-axis
                let rotationMatrix = simd_float4x4(SCNMatrix4MakeRotation(Float.pi / 4.0, 1, 0, 0))

                // Multiply the rotation matrix with the existing transformation matrix
                let rotatedMatrix = orientation * rotationMatrix

                // Set the rotation of the flower model
                smileModelNode.simdTransform = rotatedMatrix
            }
        } else {
            // Hide the flower model when not smiling
            smileModelNode?.removeFromParentNode()
        }

        if isCheekPuffed {
            // Show the banana model when the cheek is puffed
            if let bananaModelNode = bananaModelNode {
                if !sceneView.scene.rootNode.childNodes.contains(bananaModelNode) {
                    sceneView.scene.rootNode.addChildNode(bananaModelNode)
                }

                // Get the orientation of the face
                let orientation = faceAnchor.transform

                
                // Set the rotation of the banana model
                bananaModelNode.simdTransform = orientation

                // Adjust the position of the banana model
                // You may need to experiment with these values based on your model and scene
                let translation = simd_float4x4(SCNMatrix4MakeTranslation(-2, 0, -15)) // Adjust these values
                bananaModelNode.simdTransform *= translation
            }
        } else {
            // Hide the banana model when the cheek is not puffed
            bananaModelNode?.removeFromParentNode()
        }
        if isJawOpen {
                // Show the pepper model when the jaw is open
                if let pepperModelNode = pepperModelNode {
                    if !sceneView.scene.rootNode.childNodes.contains(pepperModelNode) {
                        sceneView.scene.rootNode.addChildNode(pepperModelNode)
                    }

                    // Get the orientation of the face
                    let orientation = faceAnchor.transform

                    // Set the rotation of the pepper model
                    pepperModelNode.simdTransform = orientation
                    let translation = simd_float4x4(SCNMatrix4MakeTranslation(0, 0, 0)) // Adjust these values
                    pepperModelNode.simdTransform *= translation
                }
        } else {
            // Hide the pepper model when the jaw is not open
            pepperModelNode?.removeFromParentNode()
        }
    }





    
    func expression(anchor: ARFaceAnchor) {
        let smileLeft = anchor.blendShapes[.mouthSmileLeft]
        let smileRight = anchor.blendShapes[.mouthSmileRight]
        let cheekPuff = anchor.blendShapes[.cheekPuff]
        let tongue = anchor.blendShapes[.tongueOut]
        let jawOpen = anchor.blendShapes[.jawOpen]
        let eyeBlinkLeft = anchor.blendShapes[.eyeBlinkLeft]
        let eyeBlinkRight = anchor.blendShapes[.eyeBlinkRight]
        self.analysis = ""
        
        if ((smileLeft?.decimalValue ?? 0.0) + (smileRight?.decimalValue ?? 0.0)) > 0.9 {
            self.analysis += "You are smiling. "
            // Show the flower model
                    if let smileModelNode = smileModelNode {
                        sceneView.scene.rootNode.addChildNode(smileModelNode)
                    }
                } else {
                    // Hide the flower model when not smiling
                    smileModelNode?.removeFromParentNode()
        }
        
        if cheekPuff?.decimalValue ?? 0.0 > 0.1 {
            self.analysis += "Your cheeks are puffed. "
        }
        
        if tongue?.decimalValue ?? 0.0 > 0.1 {
            self.analysis += "Don't stick your tongue out! "
        }
        if jawOpen?.decimalValue ?? 0.0 > 0.9 {
            self.analysis += "Care about your jaw!"
        }
        if eyeBlinkLeft?.decimalValue ?? 0.0 > 0.1 {
            self.analysis += "You winked. "
        }
        if eyeBlinkRight?.decimalValue ?? 0.0 > 0.1 {
            self.analysis += "You winked. "
        }
    }
}
