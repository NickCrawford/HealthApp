//
//  ORKJugglingStep.swift
//  HealthApp
//
//  Created by Nicholas Crawford on 11/15/15.
//  Copyright © 2015 Nick Crawford. All rights reserved.
//
import ResearchKit

class ORKJugglingStep: ORKActiveStep {
    
    static func stepViewControllerClass() -> JugglingStepViewController.Type {
        return JugglingStepViewController.self
    }
}