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
    
    var survey: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        if (!survey) {
            survey = true;
            startSurvey(self.view)
        } else {
            let startView = self.storyboard!.instantiateViewControllerWithIdentifier("startView") as! StartViewController
            self.presentViewController(startView, animated: true, completion: nil)
        }
        
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
            let results: ORKTaskResult = taskViewController.result
            let data: NSSecureCoding = results;
            do {
                var parseError: NSError?
            let parsedObject: AnyObject? = try NSJSONSerialization.JSONObjectWithData(ORKESerializer.JSONDataForObject(data),
                options: NSJSONReadingOptions.AllowFragments)
                print(parsedObject);
                
                let url = NSURL(string: "https://healthapp-1130.storage.googleapis.com/objectTest")
                let request = NSMutableURLRequest(URL:url!);
                request.HTTPMethod = "POST"
                // Compose a query string
                let postString = "key=objectTest&value=1";
                
                request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding);
                
                let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
                    data, response, error in
                    
                    if error != nil
                    {
                        print("error=\(error)")
                        return
                    }
                    
                    // You can print out response object
                    print("response = \(response)")
                    
                    // Print out response body
                    let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
                    print("responseString = \(responseString)")
                
                }
                
                task.resume()
            } catch is NSError {}
            
        }
        
        taskViewController.dismissViewControllerAnimated(true, completion:nil)
        
    }
}