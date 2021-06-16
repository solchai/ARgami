//
//  StepsViewController.swift
//  ARgami
//
//  Created by Solomon Chai on 2021-05-08.
//

import UIKit

class StepsViewController: UIViewController {
    
    @IBOutlet weak var contentView: UIView!
    
    let steps: [(UIImage,UIImage)]
    let name: String
    
    var currentViewControllerIndex: Int = 0
    
    init?(coder: NSCoder, steps: [(UIImage,UIImage)], name: String) {
        self.steps = steps
        self.name = name
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = name
        self.configurePageViewController()
        self.contentView.layer.masksToBounds = true
        self.contentView.layer.cornerRadius = 15
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configurePageViewController() {
        guard let pageViewController = storyboard?.instantiateViewController(identifier: String(describing: StepPagesViewController.self)) as? StepPagesViewController else {
            return
        }
        
        pageViewController.delegate = self
        pageViewController.dataSource = self
        
        addChild(pageViewController)
        pageViewController.didMove(toParent: self)
        
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(pageViewController.view)
        
        let views: [String:Any] = ["pageView": pageViewController.view!]
        
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[pageView]-0-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: views))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[pageView]-0-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: views))
        
        guard let startingViewController = stepImageViewControllerAt(index: currentViewControllerIndex) else {
            return
        }
        
        pageViewController.setViewControllers([startingViewController], direction: .forward, animated: true, completion: nil)
    }
    
    func stepImageViewControllerAt(index: Int) -> StepImageViewController? {
        if index >= steps.count || steps.count == 0 {
            return nil
        }
        
        guard let stepImageViewController = storyboard?.instantiateViewController(identifier: String(describing: StepImageViewController.self)) as? StepImageViewController else {
            return nil
        }
        
        stepImageViewController.index = index
        stepImageViewController.image = steps[index]
        
        return stepImageViewController
    }
}

extension StepsViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return currentViewControllerIndex
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return steps.count
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        let stepImageViewController = viewController as? StepImageViewController
        
        guard var currentIndex = stepImageViewController?.index else {
            return nil
        }
        
        currentViewControllerIndex = currentIndex
        
        if currentIndex == 0 {
            return nil
        }
        
        currentIndex -= 1
        
        return stepImageViewControllerAt(index: currentIndex)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let stepImageViewController = viewController as? StepImageViewController
        
        guard var currentIndex = stepImageViewController?.index else {
            return nil
        }
        
        if currentIndex == steps.count {
            return nil
        }
        
        currentIndex += 1
        currentViewControllerIndex = currentIndex
        
        return stepImageViewControllerAt(index: currentIndex)
    }
}
