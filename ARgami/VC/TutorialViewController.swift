//
//  TutorialViewController.swift
//  ARgami
//
//  Created by Solomon Chai on 2021-05-07.
//

import UIKit

class TutorialViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var tutorials = [Tutorial]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tutorials = createTutorialArray()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func createTutorialArray() -> [Tutorial] {
        return Tutorial.placeholderTutorials
    }
    
    @IBSegueAction func showSteps(_ coder: NSCoder) -> StepsViewController? {
        defer {
            tableView.deselectRow(at: tableView.indexPathForSelectedRow!, animated: true)
        }
        
        return StepsViewController(coder: coder, steps: tutorials[(tableView.indexPathForSelectedRow?.row)!].steps, name: tutorials[(tableView.indexPathForSelectedRow?.row)!].title)
    }
}

extension TutorialViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tutorials.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tutorial = tutorials[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TutorialCell") as! TutorialCell
        cell.setCell(tutorial: tutorial)
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        performSegue(withIdentifier: "showSteps", sender: self)
//    }
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard let indexPath = tableView.indexPathForSelectedRow else {
//            return
//        }
//
//        if let destination = segue.destination as? StepsViewController {
//            destination.steps = tutorials[indexPath.row].steps
//        }
//
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
    
    
}
