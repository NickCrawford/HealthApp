//
//  StartViewController.swift
//  HealthApp
//
//  Created by Nicholas Crawford on 11/14/15.
//  Copyright © 2015 Nick Crawford. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setBool(false, forKey: "shiftActive")
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func startShift(sender : AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setBool(true, forKey: "shiftActive")
        
        let dashView = self.storyboard!.instantiateViewControllerWithIdentifier("dashView") as! DashboardViewController
        self.presentViewController(dashView, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}