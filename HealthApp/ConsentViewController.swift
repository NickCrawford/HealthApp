//
//  ViewController.swift
//  HealthApp
//
//  Created by Nicholas Crawford on 11/14/15.
//  Copyright © 2015 Nick Crawford. All rights reserved.
//

import UIKit
import ResearchKit

class ConsentViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        if (!ConsentViewController.checkConsent()) {
            startConsent(self.view)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func startConsent(sender : AnyObject) {
        let taskViewController = ORKTaskViewController(task: ConsentTask, taskRunUUID: nil)
        taskViewController.delegate = self
        presentViewController(taskViewController, animated: true, completion: nil)
        
    }
    
    @IBAction func resetConsent(sender : AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setBool(false, forKey: "isUserConsented")
        ConsentViewController.checkConsent()
    }
    
    static func checkConsent()->Bool {
        let defaults = NSUserDefaults.standardUserDefaults()
        let isUserConsented = defaults.boolForKey("isUserConsented")
            
        if isUserConsented {
            print("User Consented")
            return true
        } else {
            print("User needs to consent")
            return false
        }
    }
    
}

extension ConsentViewController : ORKTaskViewControllerDelegate {
    
    func taskViewController(taskViewController: ORKTaskViewController, didFinishWithReason reason:ORKTaskViewControllerFinishReason, error: NSError?) {
        //Handle results with taskViewController.result
        if (reason == ORKTaskViewControllerFinishReason.Completed) {
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setBool(true, forKey: "isUserConsented")
        }
        
        taskViewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
}


