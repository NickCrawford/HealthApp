//
//  StartViewController.swift
//  HealthApp
//
//  Created by Nicholas Crawford on 11/14/15.
//  Copyright © 2015 Nick Crawford. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    
    @IBOutlet weak var helloLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setBool(false, forKey: "shiftActive")
        
        // Do any additional setup after loading the view, typically from a nib.
        let userName:String! = defaults.stringForKey("userName")
        
        helloLabel.text = "Hello \(userName)!"
    }
    
    @IBAction func startShift(sender : AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setBool(true, forKey: "shiftActive")
        
        let dashView = self.storyboard!.instantiateViewControllerWithIdentifier("dashView") as! DashboardViewController
        
        dashView.randTask = Int(arc4random_uniform(3))
        
        while(dashView.randTask == defaults.integerForKey("lastRandTask")) {
            dashView.randTask = Int(arc4random_uniform(3))
        }
        
        defaults.setInteger(dashView.randTask, forKey: "lastRandTask")
        
        self.presentViewController(dashView, animated: true, completion: nil)
    }
    
    @IBAction func resetConsent(sender : AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setBool(false, forKey: "isUserConsented")
        ConsentViewController.checkConsent()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}