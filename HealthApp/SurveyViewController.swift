//
//  SurveyViewController.swift
//  HealthApp
//
//  Created by Nicholas Crawford on 11/14/15.
//  Copyright © 2015 Nick Crawford. All rights reserved.
//

import UIKit
import ResearchKit

class SurveyViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        startSurvey(self.view)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startSurvey(sender: AnyObject) {
        let taskViewController = ORKTaskViewController(task: SurveyTask, taskRunUUID: nil)
        taskViewController.delegate = self
        presentViewController(taskViewController, animated: true, completion: nil)
    }
}

extension SurveyViewController : ORKTaskViewControllerDelegate {
    
    func taskViewController(taskViewController: ORKTaskViewController, didFinishWithReason reason:ORKTaskViewControllerFinishReason, error: NSError?) {
        //Handle results with taskViewController.result
        if (reason == ORKTaskViewControllerFinishReason.Completed) {
           
        }
        
        taskViewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
}