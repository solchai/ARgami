//
//  TutorialCellTableViewCell.swift
//  ARgami
//
//  Created by Solomon Chai on 2021-05-07.
//

import UIKit

class TutorialCell: UITableViewCell {
    @IBOutlet weak var previewImageView: UIImageView!
    
    @IBOutlet weak var tutorialTitleLabel: UILabel!
    
    func setCell(tutorial: Tutorial) {
        previewImageView.image = tutorial.image
        tutorialTitleLabel.text = tutorial.title
    }

}
