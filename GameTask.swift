//
//  TestViewController.swift
//  HealthApp
//
//  Created by Nicholas Crawford on 11/15/15.
//  Copyright © 2015 Nick Crawford. All rights reserved.
//

import ResearchKit

public var GameTask: ORKOrderedTask {
    
    var steps = [ORKStep]()
    
    //Show Prompt
    let promptStep = ORKInstructionStep(identifier: "promptStep")
    promptStep.title = "Fatigue Test"
    promptStep.text = "You will play through three quick games to test your fatigue levels. This should only take 2-3 minutes"
    steps += [promptStep]
    
    //Ask for feeling
    let textChoices : [ORKTextChoice] = [ORKTextChoice(text: "Poor", value: 1), ORKTextChoice(text: "Fair", value: 2), ORKTextChoice(text: "Good", value: 3), ORKTextChoice(text: "Above Average", value: 10), ORKTextChoice(text: "Excellent", value: 5)]
    
    let feelingAnswerFormat = ORKAnswerFormat.textScaleAnswerFormatWithTextChoices(textChoices, defaultIndex: NSIntegerMax, vertical: false)
    
    let feelingStep = ORKQuestionStep(identifier: "FeelingStep", title: "How are you feeling right now?", answer: feelingAnswerFormat)
    
    feelingStep.text = ""
    feelingStep.optional = false;
    
    steps += [feelingStep]
    
    
    //TODO: Implement Game Tasks
    //Countdown
    let countDownStep = ORKCountdownStep(identifier: "CountdownStep")
    steps += [countDownStep]
    
    //Test Game
    let jugglingStep = ORKJugglingStep(identifier: "JugglingStep")

    steps += [jugglingStep]
    
    let summaryStep = ORKCompletionStep(identifier: "SummaryStep")
    summaryStep.title = "Results"
    summaryStep.text = "Feeling: [Great!]\n[Game 1]: [time]\n[Game 2]: [time]\n[Game 3]: [time]\nComments:[none]"
    steps += [summaryStep]
    
    return ORKOrderedTask(identifier: "GameTask", steps: steps)
}
