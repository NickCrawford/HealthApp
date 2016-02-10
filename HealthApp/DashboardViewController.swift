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
    
    
    @IBOutlet var game1Label: UILabel!
    
    @IBOutlet var game1Result: UILabel!
    
    @IBOutlet var feelingResult: UILabel!
    
    var tasksCompleted = 0;
    
    var lastResults: [[AnyObject]] = [["Feeling", ""], ["Game 1", "Result"], ["Comments", "comments"]]
    
    var randTask:Int = 0;
    
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
            let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("startView")
            self.showViewController(vc as! UIViewController, sender: vc)
        }
        if (tasksCompleted <= 1 && tasksCompleted > 0) {
            let gameViewController = ORKTaskViewController(task: getTask(), taskRunUUID: nil)
            gameViewController.delegate = self
            presentViewController(gameViewController, animated: true, completion: {self.tasksCompleted += 1})
        } else if (tasksCompleted == 2) {
            //show completion and collect addt comments
            let gameViewController = ORKTaskViewController(task: GameCompletionTask, taskRunUUID: nil)
            gameViewController.delegate = self
            presentViewController(gameViewController, animated: true, completion: {self.tasksCompleted += 1})
        }
        
        
        if (tasksCompleted > 2) {
            self.game1Label.text = lastResults[1][0] as! String
            
            self.feelingResult.text = "\(lastResults[0][1])/5"
            self.game1Result.text = lastResults[1][1] as! String
        }
        
    }
    
    @IBAction func startTest(sender : AnyObject) {
        //Show Summary Task and collect user feeling
        if (tasksCompleted == 0) {
            var gameViewController = ORKTaskViewController(task: GameSummaryTask, taskRunUUID: nil)
            gameViewController.delegate = self
            presentViewController(gameViewController, animated: true, completion: {self.tasksCompleted += 1})
        }
        
        
    }
    
    @IBAction func endShift(sender : AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setBool(false, forKey: "shiftActive")

        let startView = self.storyboard!.instantiateViewControllerWithIdentifier("startView") as! StartViewController
       
        self.presentViewController(startView, animated: true, completion: nil)
        
        //self.dismissViewControllerAnimated(true, completion: nil)
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
    
    
    
    enum Identifier: Int {
        // Active tasks.
        case HolePegTestTask = 0
        case SpatialSpanMemoryTask=1
        case TwoFingerTappingIntervalTask=2
    }
    
    /// This task presents the Hole Peg Test pre-defined active task.
    private var holePegTestTask: ORKTask {
        return ORKNavigableOrderedTask.holePegTestTaskWithIdentifier(String(Identifier.HolePegTestTask), intendedUseDescription: "", dominantHand: .Right, numberOfPegs: 3, threshold: 0.2, rotated: false, timeLimit: 100, options: [])
    }
    
    /// This task presents the Spatial Span Memory pre-defined active task.
    private var spatialSpanMemoryTask: ORKTask {
        return ORKOrderedTask.spatialSpanMemoryTaskWithIdentifier(String(Identifier.SpatialSpanMemoryTask), intendedUseDescription: "", initialSpan: 3, minimumSpan: 2, maximumSpan: 15, playSpeed: 1.0, maxTests: 5, maxConsecutiveFailures: 3, customTargetImage: nil, customTargetPluralName: nil, requireReversal: false, options: [])
    }
    
    /// This task presents the Two Finger Tapping pre-defined active task.
    private var twoFingerTappingIntervalTask: ORKTask {
        return ORKOrderedTask.twoFingerTappingIntervalTaskWithIdentifier(String(Identifier.TwoFingerTappingIntervalTask), intendedUseDescription: "", duration: 10, options: [])
    }
    
    enum ActiveTasks: Int {
        case HolePegTest = 0
        case SpatialSpanMemory = 1
        case TwoFingerTappingInterval = 2
    }
    
    func getTask() -> ORKTask {
        
        var task: ORKTask {
            switch randTask {
            case 0:
                return holePegTestTask
                
            case 1:
                return spatialSpanMemoryTask
                
            case 2:
                return twoFingerTappingIntervalTask
            
            default:
                return holePegTestTask
            }

        }
        return task
    }
}

extension DashboardViewController : ORKTaskViewControllerDelegate {
    
    func taskViewController(taskViewController: ORKTaskViewController, didFinishWithReason reason:ORKTaskViewControllerFinishReason, error: NSError?) {
        //Handle Cancellation
        if (reason == ORKTaskViewControllerFinishReason.Discarded) {
            tasksCompleted = 0;
            
        }
        
        //Handle results with taskViewController.result
        if (reason == ORKTaskViewControllerFinishReason.Completed) {
            let results: ORKTaskResult = taskViewController.result
            let data: NSSecureCoding = results;
            do {
                var parseError: NSError?
                let parsedObject: AnyObject? = try NSJSONSerialization.JSONObjectWithData(ORKESerializer.JSONDataForObject(data),
                    options: NSJSONReadingOptions.AllowFragments)
                print(parsedObject);
            } catch is NSError{
            
            } catch is NSException {
            
            }
            
            if results.identifier == "GameSummaryTask" {
                
                lastResults[0][1] = (results.stepResultForStepIdentifier("FeelingStep")?.firstResult?.valueForKeyPath("choiceAnswers"))!
                print(lastResults[0][1])
            }
            
            if results.identifier == "GameCompletionTask" {
                lastResults[2][0] = "Comments"
                lastResults[2][1] = (results.stepResultForStepIdentifier("CommentStep")?.firstResult?.valueForKeyPath("textAnswer"))!
                print(lastResults[2][1])
                
                tasksCompleted = 0;
            }
            
            ///Get feeling
            
            //Get results of game tests
            
            //get additional comments
            
        }
        
        taskViewController.dismissViewControllerAnimated(true, completion:nil)
        
    }
}
