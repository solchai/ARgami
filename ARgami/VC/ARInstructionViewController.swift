//
//  ARInstructionViewController.swift
//  ARgami
//
//  Created by Solomon Chai on 2021-05-16.
//

import UIKit
import SceneKit
import ARKit
import Vision

class ARInstructionViewController: UIViewController, ARSCNViewDelegate, ARSessionDelegate {
    
    @IBOutlet weak var sceneView: ARSCNView!
    private var selectedRectangleOutlineLayer: CAShapeLayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.delegate = self
        sceneView.session.delegate = self
        
        sceneView.autoenablesDefaultLighting = true
        
        let scene = SCNScene()
        sceneView.scene = scene
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    @IBAction func dismissView(_ sender: UIButton) {
        if let layer = self.selectedRectangleOutlineLayer {
            layer.removeFromSuperlayer()
            self.selectedRectangleOutlineLayer = nil
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first,
            let currentFrame = sceneView.session.currentFrame else {
            return
        }
        
        findReectangle(locationInScene: touch.location(in: sceneView), frame: currentFrame)
    }
    
    private func findReectangle(locationInScene location: CGPoint, frame currentFrame: ARFrame) {
        let interfaceOrientation = UIApplication.shared.statusBarOrientation
        let imageOrientation = interfaceOrientation.imageOrientation
        let sceneSize = sceneView.frame.size
        
        let fromCameraImageToViewTransform = currentFrame.displayTransformCorrected(
          for: interfaceOrientation,
          viewportSize: sceneSize
        )
        
        DispatchQueue.global(qos: .background).async {
            let request = VNDetectRectanglesRequest(completionHandler: { (request, error) in
                
                DispatchQueue.main.async {
                    guard let observations = request.results as? [VNRectangleObservation], observations.first != nil else {
                        print("Could not detect rectangle")
                        return
                    }
                    
                    if let layer = self.selectedRectangleOutlineLayer {
                        layer.removeFromSuperlayer()
                        self.selectedRectangleOutlineLayer = nil
                    }
                    
                    print("\(observations.first) rectangles found")
                    
                    if let observation = observations.first {
                        let normalizedPoints = [observation.topLeft, observation.topRight, observation.bottomRight, observation.bottomLeft]
                        let convertedPoints = normalizedPoints.map { $0.applying(fromCameraImageToViewTransform) }
                        let layer = self.drawPolygon(convertedPoints, color: .yellow)
                        self.sceneView.layer.addSublayer(layer)
                        self.selectedRectangleOutlineLayer = layer
                        
                        let convertedRect = observation.boundingBox.applying(fromCameraImageToViewTransform)
                        
                        guard convertedRect.contains(location) else {
                            print("No rectangle at touch location")
                            return
                        }
                        
                        self.addPlaneRect(for: observation, transform: fromCameraImageToViewTransform)
                    }
                    
                    
                }
            })
            
            let handler = VNImageRequestHandler(cvPixelBuffer: currentFrame.capturedImage, orientation: imageOrientation, options: [:])
            
            request.maximumObservations = 1
            
            try? handler.perform([request])
        }
    }
    
    private func drawPolygon(_ points: [CGPoint], color: UIColor) -> CAShapeLayer {
        let layer = CAShapeLayer()
        layer.fillColor = nil
        layer.strokeColor = color.cgColor
        layer.lineWidth = 2
        let path = UIBezierPath()
        path.move(to: points.last!)
        points.forEach { point in
            path.addLine(to: point)
        }
        layer.path = path.cgPath

        layer.addSublayer(drawPoint(points[0], color: .red))
        layer.addSublayer(drawPoint(points[1], color: .green))
        layer.addSublayer(drawPoint(points[2], color: .blue))
        layer.addSublayer(drawPoint(points[3], color: .yellow))

        return layer
    }
    
    private func drawPoint(_ point: CGPoint, color: UIColor, radius: CGFloat = 5) -> CAShapeLayer {
        let layer = CAShapeLayer()
        layer.fillColor = color.cgColor
        let path = UIBezierPath(ovalIn: CGRect(
            x: point.x - radius,
            y: point.y - radius,
            width: radius * 2,
            height: radius * 2
        ))
        layer.path = path.cgPath
        return layer
    }
    
    private func getPlaneWithRectangle(_ observation: [CGPoint]) {
        let node = SCNNode()
        
        let plane = SCNPlane(width: CGFloat(powf(Float(observation[0].x - observation[1].x), 2) + powf(Float(observation[0].y - observation[1].y), 2)).squareRoot(), height: CGFloat(powf(Float(observation[1].x - observation[2].x), 2) + powf(Float(observation[1].y - observation[2].y), 2)).squareRoot() )
        
        let planeNode = SCNNode(geometry: plane)
        planeNode.eulerAngles.x = -.pi / 2
        
        node.addChildNode(planeNode)
        
        sceneView.scene.rootNode.addChildNode(node)
    }
    
    private func addPlaneRect(for observedRect: VNRectangleObservation, transform: CGAffineTransform) {
    // Remove old outline of selected rectangle
    if let layer = selectedRectangleOutlineLayer {
        layer.removeFromSuperlayer()
        selectedRectangleOutlineLayer = nil
    }
    
    // Convert to 3D coordinates
    guard let planeRectangle = PlaneRectangle(for: observedRect, in: sceneView, with: transform) else {
        print("No plane for this rectangle")
        return
    }
    
    let rectangleNode = RectangleNode(planeRectangle)
    sceneView.scene.rootNode.addChildNode(rectangleNode)
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
