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
    
    
    var tasksCompleted = 0;
    
    var lastResults: [[AnyObject]] = [["Feeling", ""], ["Game 1", "Result"], ["Game 2", "Result"], ["Game 3", "Result"], ["Comments", "comments"]]
    
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
        if (tasksCompleted <= 3 && tasksCompleted > 0) {
            let gameViewController = ORKTaskViewController(task: getTask(), taskRunUUID: nil)
            gameViewController.delegate = self
            presentViewController(gameViewController, animated: true, completion: {self.tasksCompleted += 1})
        } else if (tasksCompleted == 4) {
            //show completion and collect addt comments
            let gameViewController = ORKTaskViewController(task: GameCompletionTask, taskRunUUID: nil)
            gameViewController.delegate = self
            presentViewController(gameViewController, animated: true, completion: {self.tasksCompleted += 1})
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
        case FitnessTask = 0
        case HolePegTestTask = 1
        case PSATTask=2
        case ReactionTime=3
        case ShortWalkTask=4
        case SpatialSpanMemoryTask=5
        case TimedWalkTask=6
        case ToneAudiometryTask=7
        case TowerOfHanoi=8
        case TwoFingerTappingIntervalTask=9
    }
    
    
    
    
    /// This task presents the Audio pre-defined active task.
//    private var audioTask: ORKTask {
//        return ORKOrderedTask.audioTaskWithIdentifier(String(Identifier.AudioTask), intendedUseDescription: "", speechInstruction: "Yell: AHHHHHHHHHH!!!!!", shortSpeechInstruction: "", duration: 20, recordingSettings: nil, options: [])
//    }
    
    /**
     This task presents the Fitness pre-defined active task. For this example,
     short walking and rest durations of 20 seconds each are used, whereas more
     realistic durations might be several minutes each.
     */
    private var fitnessTask: ORKTask {
        return ORKOrderedTask.fitnessCheckTaskWithIdentifier(String(Identifier.FitnessTask), intendedUseDescription: "", walkDuration: 20, restDuration: 20, options: [])
    }
    
    /// This task presents the Hole Peg Test pre-defined active task.
    private var holePegTestTask: ORKTask {
        return ORKNavigableOrderedTask.holePegTestTaskWithIdentifier(String(Identifier.HolePegTestTask), intendedUseDescription: "", dominantHand: .Right, numberOfPegs: 9, threshold: 0.2, rotated: false, timeLimit: 300, options: [])
    }
    
    /// This task presents the PSAT pre-defined active task.
    private var PSATTask: ORKTask {
        return ORKOrderedTask.PSATTaskWithIdentifier(String(Identifier.PSATTask), intendedUseDescription: "", presentationMode: ORKPSATPresentationMode.Auditory.union(.Visual), interStimulusInterval: 3.0, stimulusDuration: 1.0, seriesLength: 20, options: [])
    }
    
    /// This task presents the Reaction Time pre-defined active task.
    private var reactionTimeTask: ORKTask {
        /// An example of a custom sound.
        //    let successSoundURL = NSBundle.mainBundle().URLForResource("tap", withExtension: "aif")!
        //    let successSound = SystemSound(soundURL: successSoundURL)!
        return ORKOrderedTask.reactionTimeTaskWithIdentifier(String(Identifier.ReactionTime), intendedUseDescription: "", maximumStimulusInterval: 10, minimumStimulusInterval: 4, thresholdAcceleration: 0.5, numberOfAttempts: 3, timeout: 3, successSound: 0, timeoutSound: 0, failureSound: UInt32(kSystemSoundID_Vibrate), options: [])
    }
    
    /// This task presents the Gait and Balance pre-defined active task.
    private var shortWalkTask: ORKTask {
        return ORKOrderedTask.shortWalkTaskWithIdentifier(String(Identifier.ShortWalkTask), intendedUseDescription: "", numberOfStepsPerLeg: 20, restDuration: 20, options: [])
    }
    
    /// This task presents the Spatial Span Memory pre-defined active task.
    private var spatialSpanMemoryTask: ORKTask {
        return ORKOrderedTask.spatialSpanMemoryTaskWithIdentifier(String(Identifier.SpatialSpanMemoryTask), intendedUseDescription: "", initialSpan: 3, minimumSpan: 2, maximumSpan: 15, playSpeed: 1.0, maxTests: 5, maxConsecutiveFailures: 3, customTargetImage: nil, customTargetPluralName: nil, requireReversal: false, options: [])
    }
    
    /// This task presents the Timed Walk pre-defined active task.
    private var timedWalkTask: ORKTask {
        return ORKOrderedTask.timedWalkTaskWithIdentifier(String(Identifier.TimedWalkTask), intendedUseDescription: "", distanceInMeters: 100.0, timeLimit: 180.0, options: [])
    }
    
    /// This task presents the Tone Audiometry pre-defined active task.
//    private var toneAudiometryTask: ORKTask {
//        return ORKOrderedTask.toneAudiometryTaskWithIdentifier(String(Identifier.ToneAudiometryTask), intendedUseDescription: "", speechInstruction: nil, shortSpeechInstruction: nil, toneDuration: 20, options: [])
//    }
    
    private var towerOfHanoiTask: ORKTask {
        return ORKOrderedTask.towerOfHanoiTaskWithIdentifier(String(Identifier.TowerOfHanoi), intendedUseDescription: "", numberOfDisks: 5, options: [])
    }
    
    /// This task presents the Two Finger Tapping pre-defined active task.
    private var twoFingerTappingIntervalTask: ORKTask {
        return ORKOrderedTask.twoFingerTappingIntervalTaskWithIdentifier(String(Identifier.TwoFingerTappingIntervalTask), intendedUseDescription: "", duration: 20, options: [])
    }
    
    enum ActiveTasks: Int {
        case Fitness = 0
        case HolePegTest = 1
        case PSAT = 2
        case ReactionTime = 3
        case ShortWalk = 4
        case SpatialSpanMemory = 5
        case TimedWalk = 6
        case TowerOfHanoi = 7
        case TwoFingerTappingInterval = 8
    }
    
    func getTask() -> ORKTask {
        let rand = Int(arc4random_uniform(9))
        
        var task: ORKTask {
            switch rand {
//            case .Audio:
//                return audioTask
                
            case 0:
                return fitnessTask
                
            case 1:
                return holePegTestTask
                
            case 2:
                return PSATTask
                
            case 3:
                return reactionTimeTask
                
            case 4:
                return shortWalkTask
                
            case 5:
                return spatialSpanMemoryTask
                
            case 6:
                return timedWalkTask
                
                
            case  7:
                return towerOfHanoiTask
                
            case 8:
                return twoFingerTappingIntervalTask
            
            default:
                return fitnessTask
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
            } catch is NSError {}
            
            if results.identifier == "GameSummaryTask" {
                
                lastResults[0][1] = (results.stepResultForStepIdentifier("FeelingStep")?.firstResult?.valueForKeyPath("choiceAnswers"))!
                print(lastResults[0][1])
            }
            
            if results.identifier == "towerOfHanoi" {
                lastResults[tasksCompleted][0] = "Tower of Hanoi"
                lastResults[tasksCompleted][1] = (results.stepResultForStepIdentifier("towerOfHanoi")?.firstResult?.valueForKeyPath("moves"))!
            }
            
                

            
            
            if results.identifier == "GameCompletionTask" {
                lastResults[4][0] = "Comments"
                lastResults[4][1] = (results.stepResultForStepIdentifier("CommentStep")?.firstResult?.valueForKeyPath("textAnswer"))!
                print(lastResults[4][1])
                
                tasksCompleted = 0;
            }
            
            ///Get feeling
            
            //Get results of game tests
            
            //get additional comments
            
        }
        
        taskViewController.dismissViewControllerAnimated(true, completion:nil)
        
    }
}
