//
//  ConsentTask.swift
//  Camelot
//
//  Created by Nicholas Crawford on 11/14/15.
//  Copyright © 2015 Nick Crawford. All rights reserved.
//

import Foundation
import ResearchKit

public var ConsentTask: ORKOrderedTask {
    
    var steps = [ORKStep]()
    
    var consentDocument = ConsentDocument
    let visualConsentStep = ORKVisualConsentStep(identifier: "VisualConsentStep", document: consentDocument)
    steps += [visualConsentStep]
    
    let signature = consentDocument.signatures!.first as! ORKConsentSignature!
    signature.requiresName = true;
    
    
    let reviewConsentStep = ORKConsentReviewStep(identifier: "nameStep", signature: signature, inDocument: consentDocument)
    
    reviewConsentStep.title = "Name"
    reviewConsentStep.text = "Enter your name below to consent to the study"
    steps += [reviewConsentStep]
    
    return ORKOrderedTask(identifier: "ConsentTask", steps: steps)
}
