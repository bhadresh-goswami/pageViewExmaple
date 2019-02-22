//
//  PageViewController.swift
//  pageViewExmaple
//
//  Created by Mac on 22/02/19.
//  Copyright © 2019 bhadresh. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self

        if let firstView = Pages.first{
            setViewControllers([firstView], direction: .forward, animated: true, completion: { (isDone) in
                print("Ok")
            })
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    lazy var Pages:[UIViewController] = {
        return [
            newVc(viewController: "redScene"),
            newVc(viewController: "blueScene")
        ]
    }()

}



extension PageViewController:UIPageViewControllerDelegate, UIPageViewControllerDataSource{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let indexOfController = Pages.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = indexOfController - 1
        guard (previousIndex >= 0) else
        {
            //return Pages[currentIndex]
            return Pages.last
        }
        
        guard Pages.count > previousIndex else {
            return nil
        }
        
        return Pages[previousIndex]
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = Pages.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = Pages.count
        
        // User is on the last view controller and swiped right to loop to
        // the first view controller.
        guard orderedViewControllersCount != nextIndex else {
            return Pages.first
            // Uncommment the line below, remove the line above if you don't want the page control to loop.
            // return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return Pages[nextIndex]
    }
    
    
    func newVc(viewController: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: viewController)
    }
    
    
}
