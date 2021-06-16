//
//  DataViewController.swift
//  ARgami
//
//  Created by Solomon Chai on 2021-05-08.
//

import UIKit

class StepImageViewController: UIViewController {
    @IBOutlet weak var stepImage: UIImageView!
    var image: (UIImage, UIImage)?
    var index: Int?
    
    var cameraView: ARInstructionViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.stepImage.image = image?.0
        // Do any additional setup after loading the view.
        guard let arViewController = storyboard?.instantiateViewController(identifier: String(describing: ARInstructionViewController.self)) as? ARInstructionViewController else {
            return
        }
        
        arViewController.modalPresentationStyle = .fullScreen
        arViewController.arOverlayImage = image?.1
        
        cameraView = arViewController
    }
    
    @IBAction func showARStep(_ sender: UIButton) {
        if let arView = cameraView {
            present(arView, animated: true, completion: nil)
        }
    }
}
