//
//  CameraViewController.swift
//  ARgami
//
//  Created by Solomon Chai on 2021-05-09.
//
// no ARKit
import UIKit
import AVKit
import Vision

class CameraViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    var session: AVCaptureSession?
    
    let closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark.seal.fill"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = UIColor(named: "TextColour")!
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let captureSession = AVCaptureSession()
        self.session = captureSession
        captureSession.sessionPreset = .photo
        
        guard let captureDevice = AVCaptureDevice.default(for: .video) else { return }
        guard let input = try? AVCaptureDeviceInput(device: captureDevice) else { return }
        captureSession.addInput(input)
        
        captureSession.startRunning()
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        view.layer.addSublayer(previewLayer)
        previewLayer.frame = view.frame
        
        let dataOutput = AVCaptureVideoDataOutput()
        dataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
        captureSession.addOutput(dataOutput)
        
        self.setUpCloseButton()
    }
    
    fileprivate func setUpCloseButton() {
        view.addSubview(closeButton)
//        let widthContraints =  NSLayoutConstraint(item: closeButton, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 30)
//        let heightContraints =  NSLayoutConstraint(item: closeButton, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 30)
//        let trailContraints = NSLayoutConstraint(item: closeButton, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: -50)
//        let topContraints = NSLayoutConstraint(item: closeButton, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: -50)
//        NSLayoutConstraint.activate([widthContraints, heightContraints, trailContraints, topContraints])
        
//        closeButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32).isActive = true
//        closeButton.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        closeButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        closeButton.imageView?.contentMode = .scaleAspectFit

        closeButton.addTarget(self, action: #selector(self.dismissCamera(sender:)), for: .touchUpInside)
    }

    @objc func dismissCamera(sender: UIButton!) {
        self.session?.stopRunning()
        self.dismiss(animated: true, completion: nil)
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let pixelBuffer: CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            return
        }
        /// use to get pixelbuffer from ARscenes
//        let pixelBuffer = sceneView?.session.currentFrame?.capturedImage
//        let handler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, orientation: .up)
        
        let requestHandler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:])
        let request = VNDetectRectanglesRequest { request, error  in
            self.completedVisionRequest(request, error: error)
        }
        request.usesCPUOnly = false
        
        DispatchQueue.global().async {
            do {
                try requestHandler.perform([request])
            } catch {
                print("Error: Rectangle detection failed - vision request failed.")
            }
        }
    }
    
    func completedVisionRequest(_ request: VNRequest?, error: Error?) {
        // Only proceed if a rectangular image was detected.
        guard let rectangles = request?.results as? [VNRectangleObservation] else {
            if let error = error {
                print("Error: Rectangle detection failed - Vision request returned an error. \(error.localizedDescription)")
            }
            return
        }
        // do stuff with rectangles
        for rectangle in rectangles {
            print("DETECTED: \(rectangle.boundingBox)")
        }
    }
    
    func addOverlayToRectangle(_ rectangle: VNRectangleObservation) {
        
    }
}
