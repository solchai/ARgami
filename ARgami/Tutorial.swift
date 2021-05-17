//
//  Tutorial.swift
//  ARgami
//
//  Created by Solomon Chai on 2021-05-07.
//

import Foundation
import UIKit

class Tutorial {
    var image: UIImage
    var title: String
    var steps: [UIImage]
    
    init(image: UIImage, title: String, steps: [UIImage]) {
        self.image = image
        self.title = title
        self.steps = steps
    }
    
    static var placeholderTutorials: [Tutorial] = {
        let foxSteps = [UIImage(named: "fox-instruct1")!, UIImage(named: "fox-instruct2")!, UIImage(named: "fox-instruct3")!, UIImage(named: "fox-instruct4")!, UIImage(named: "fox-instruct5")!]
        
        let tutorial1 = Tutorial(image: UIImage(named: "fox-origami")!, title: "Foxy the Fox", steps: foxSteps)
        let tutorial2 = Tutorial(image: UIImage(named: "hoppingfrog-origami")!, title: "Hoppity Frog", steps: [UIImage(named: "hoppingfrog-origami")!])
        let tutorial3 = Tutorial(image: UIImage(named: "crane-origami")!, title: "Swifty Crane", steps: [UIImage(named: "crane-origami")!])
        let tutorial4 = Tutorial(image: UIImage(named: "reindeer-origami")!, title: "Happy Reindeer", steps: [UIImage(named: "reindeer-origami")!])
        let tutorial5 = Tutorial(image: UIImage(named: "dragon-origami")!, title: "Fierce Drangon", steps: [UIImage(named: "dragon-origami")!,])
        
        var tutorialArray = [Tutorial]()
        tutorialArray.append(tutorial1)
        tutorialArray.append(tutorial2)
        tutorialArray.append(tutorial3)
        tutorialArray.append(tutorial4)
        tutorialArray.append(tutorial5)
        
        return tutorialArray
    }()
}
