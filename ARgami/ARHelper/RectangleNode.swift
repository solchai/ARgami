//
//  RectangleNode.swift
//  ARgami
//
//  Created by Solomon Chai on 2021-05-16.
//

import UIKit
import SceneKit
import ARKit
import Vision

private let meters2inches = CGFloat(39.3701)

class RectangleNode: SCNNode {
    
    convenience init(_ planeRectangle: PlaneRectangle, _ image: UIImage? = nil) {
        self.init(center: planeRectangle.position,
        width: planeRectangle.size.width,
        height: planeRectangle.size.height,
        orientation: planeRectangle.orientation,
        image: image)
    }
    
    init(center position: SCNVector3, width: CGFloat, height: CGFloat, orientation: Float, image: UIImage? = nil) {
        super.init()
        
        // Debug
        print("position: \(position) width: \(width) (\(width * meters2inches)\") height: \(height) (\(height * meters2inches)\")")
        
        // Create the 3D plane geometry with the dimensions calculated from corners
        let planeGeometry = SCNPlane(width: width, height: height)
        
        if let image = image {
            planeGeometry.firstMaterial?.diffuse.contents = image
            planeGeometry.firstMaterial?.isDoubleSided = true
        } else {
            planeGeometry.firstMaterial?.diffuse.contents = UIColor(white: 1.0, alpha: 0.7)
        }
        
        
        let rectNode = SCNNode(geometry: planeGeometry)

        // Planes in SceneKit are vertical by default so we need to rotate
        // 90 degrees to match planes in ARKit
        var transform = SCNMatrix4MakeRotation(-Float.pi / 2.0, 1.0, 0.0, 0.0)
        
        // Set rotation to the corner of the rectangle
        transform = SCNMatrix4Rotate(transform, orientation, 0, 0, 1)
        
        rectNode.transform = transform
        
        // We add the new node to ourself since we inherited from SCNNode
        self.addChildNode(rectNode)
        
        // Set position to the center of rectangle
        self.position = position
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


