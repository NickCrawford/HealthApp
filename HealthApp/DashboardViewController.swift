//
//  DashboardViewController.swift
//  HealthApp
//
//  Created by Nicholas Crawford on 11/14/15.
//  Copyright © 2015 Nick Crawford. All rights reserved.
//

import Foundation
import UIKit

class DashboardViewController : UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        
        if (!ConsentViewController.checkConsent()) {
            let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("consentView")
            self.showViewController(vc as! UIViewController, sender: vc)
        }
        
        if(!DashboardViewController.checkShift()) {
            print("Here")
            let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("startView")
            self.showViewController(vc as! UIViewController, sender: vc)
        }
    }
    
    @IBAction func startTest(sender : AnyObject) {
        let gameViewController = ORKTaskViewController(task: GameTask, taskRunUUID: nil)
        gameViewController.delegate = self
        presentViewController(gameViewController, animated: true, completion: nil)
        
    }
    
    @IBAction func endShift(sender : AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setBool(false, forKey: "shiftActive")

        defaults.setBool(false, forKey: "isUserConsented")
        
        let startView = self.storyboard!.instantiateViewControllerWithIdentifier("startView") as! StartViewController
        self.presentViewController(startView, animated: true, completion: nil)
    }
    
    static func checkShift()->Bool {
        let defaults = NSUserDefaults.standardUserDefaults()
        let shiftActive = defaults.boolForKey("shiftActive")
        
        if shiftActive {
            print("Shift Active")
            return true
        } else {
            print("Shift not activet")
            return false
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

extension DashboardViewController : ORKTaskViewControllerDelegate {
    
    func taskViewController(taskViewController: ORKTaskViewController, didFinishWithReason reason:ORKTaskViewControllerFinishReason, error: NSError?) {
        //Handle results with taskViewController.result
        if (reason == ORKTaskViewControllerFinishReason.Completed) {
            let results: ORKTaskResult = taskViewController.result
            let data: NSSecureCoding = results;
            do {
                var parseError: NSError?
                let parsedObject: AnyObject? = try NSJSONSerialization.JSONObjectWithData(ORKESerializer.JSONDataForObject(data),
                    options: NSJSONReadingOptions.AllowFragments)
                print(parsedObject);
            } catch is NSError {}
            
        }
        
        taskViewController.dismissViewControllerAnimated(true, completion:nil)
        
    }
}
