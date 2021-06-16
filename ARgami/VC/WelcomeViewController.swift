//
//  WelcomeViewController.swift
//  ARgami
//
//  Created by Solomon Chai on 2021-05-07.
//

import UIKit

class WelcomeViewController: UIViewController {
    @IBOutlet weak var tutorialButton: UIButton!
    
    @IBOutlet weak var othersButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Welcome!"
        
        tutorialButton.backgroundColor = UIColor(named: "TutorialColour")
        tutorialButton.layer.masksToBounds = true
        tutorialButton.layer.cornerRadius = 10
        
        othersButton.backgroundColor = UIColor(named: "OtherColour")
        othersButton.layer.masksToBounds = true
        othersButton.layer.cornerRadius = 10
    }
}
