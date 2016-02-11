//
//  RoleDocument.swift
//  HealthApp
//
//  Created by Nicholas Crawford on 11/14/15.
//  Copyright © 2015 Nick Crawford. All rights reserved.
//
import ResearchKit

public var SurveyTask: ORKOrderedTask {
    
    var steps = [ORKStep]()
    
    //Show Instructions
    let instructionStep = ORKInstructionStep(identifier: "IntroStep")
    instructionStep.title = "Almost Done"
    instructionStep.text = "We just need a few more details to start!"
    steps += [instructionStep]

    //Ask for Role
    let positionAnswerFormat = ORKTextAnswerFormat(maximumLength: 40)
    positionAnswerFormat.multipleLines = false
    let positionQuestionStepTitle = "What is your occupation?"
    let positionQuestionStep = ORKQuestionStep(identifier: "OccupationStep", title: positionQuestionStepTitle, answer: positionAnswerFormat)
    steps += [positionQuestionStep]
    
    let locationAnswerFormat = ORKTextAnswerFormat(maximumLength: 40)
    locationAnswerFormat.multipleLines = false
    let locationQuestionStepTitle = "Where do you work?"
    let locationQuestionStep = ORKQuestionStep(identifier: "LocationStep", title: locationQuestionStepTitle, answer: locationAnswerFormat)
    steps += [locationQuestionStep]
    
    let summaryStep = ORKCompletionStep(identifier: "SummaryStep")
    summaryStep.title = "Thanks"
    summaryStep.text = "You're all set!"
    steps += [summaryStep]
    
    return ORKOrderedTask(identifier: "SurveyTask", steps: steps)
}