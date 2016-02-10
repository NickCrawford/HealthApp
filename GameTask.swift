//
//  TestViewController.swift
//  HealthApp
//
//  Created by Nicholas Crawford on 11/15/15.
//  Copyright © 2015 Nick Crawford. All rights reserved.
//

import ResearchKit

public var GameSummaryTask: ORKTask {
    var steps = [ORKStep]()
    
    //Show Prompt
    let promptStep = ORKInstructionStep(identifier: "promptStep")
    promptStep.title = "Fatigue Test"
    promptStep.text = "You will play through two quick games to test your fatigue levels. This should only take 2-3 minutes"
    steps += [promptStep]
    
    //Ask for feeling
    let textChoices : [ORKTextChoice] = [ORKTextChoice(text: "Poor", value: 1), ORKTextChoice(text: "Fair", value: 2), ORKTextChoice(text: "Good", value: 3), ORKTextChoice(text: "Above Average", value: 4), ORKTextChoice(text: "Excellent", value: 5)]
    
    let feelingAnswerFormat = ORKAnswerFormat.textScaleAnswerFormatWithTextChoices(textChoices, defaultIndex: NSIntegerMax, vertical: false)
    
    let feelingStep = ORKQuestionStep(identifier: "FeelingStep", title: "How are you feeling right now?", answer: feelingAnswerFormat)
    
    feelingStep.text = ""
    feelingStep.optional = false;
    
    steps += [feelingStep]
    return ORKOrderedTask(identifier: "GameSummaryTask", steps: steps)
}

public var GameCompletionTask: ORKTask {
    var steps = [ORKStep]()
    
    let commentStepFormat = ORKTextAnswerFormat(maximumLength: 200)
    commentStepFormat.multipleLines = true
    let commentStepTitle = "Additional Comments"
    let commentStep = ORKQuestionStep(identifier: "CommentStep", title: commentStepTitle, answer: commentStepFormat)
    commentStep.text = "Would you like to add some comments about this test? (i.e. What were you doing before the test? Feeling particularly bad or good?"
    steps += [commentStep]
  
    
    //show summary, go to dashboard
    let summaryStep = ORKCompletionStep(identifier: "SummaryStep")
    summaryStep.title = "All done!"
    steps += [summaryStep]
    
    return ORKOrderedTask(identifier: "GameCompletionTask", steps: steps)
    
}

