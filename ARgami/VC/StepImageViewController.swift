//
//  DataViewController.swift
//  ARgami
//
//  Created by Solomon Chai on 2021-05-08.
//

import UIKit

class StepImageViewController: UIViewController {
    @IBOutlet weak var stepImage: UIImageView!
    var image: UIImage?
    var index: Int?
    
    var cameraView: ARInstructionViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.stepImage.image = image
        // Do any additional setup after loading the view.
        guard let arViewController = storyboard?.instantiateViewController(identifier: String(describing: ARInstructionViewController.self)) as? ARInstructionViewController else {
            return
        }
        
        arViewController.modalPresentationStyle = .fullScreen
        
        cameraView = arViewController
    }
    
    @IBAction func showARStep(_ sender: UIButton) {
        if let arView = cameraView {
            present(arView, animated: true, completion: nil)
        }
//        show(cameraView, sender: self)
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
