//
//  ConsentDocument.swift
//  Camelot
//
//  Created by Nicholas Crawford on 11/14/15.
//  Copyright © 2015 Nick Crawford. All rights reserved.
//

import Foundation

import ResearchKit

public var ConsentDocument: ORKConsentDocument {
    
    let consentDocument = ORKConsentDocument()
    consentDocument.title = "Example Consent"
    
    let consentSectionTypes: [ORKConsentSectionType] = [
        .Overview,
        .DataGathering,
        .Privacy,
        //.DataUse,
        .TimeCommitment,
        //.StudySurvey,
        //.StudyTasks,
        .Withdrawing
    ]
    
    let summaries = [
        "Research Overview",
        "Data Gathering & Use",
        "Research Privacy",
        "Time Commitment & Study Tests",
        "Withdrawing from Research Study"
    ]
    
    let contents = [
        "[APPNAME] is collecting data to research and study the short term effects of working long shifts as a physician. We hope this data will give us a better insight on how physicians may be impaired as the work.",
        "[APPNAME] collects data and provides a summary to you at the end of each shift. This data will then be submitted to a central database where the information of all participants will be used to study the short term effects of working long shifts.",
        "The data you provide will be saved to a secure database and used for research purposes. At any-time you may opt out of this research by clicking ‘Withdraw’. In the event that a presentation of this data is created we will not use your personal data. We may contact you to talk about your experience and share with you what our data has found. Researchers like Dr. Saadat at Nationwide Children’s Hospital have received approval from an Institutional Review Board (IRB) to conduct such a study to show the “Effects of Partial Sleep Deprivation on Mood, Cognitive Tasks and Speed in Anesthesiologists”. The results were very telling and Dr. Saadat has been asked to expand her study for other sites.",
        "Time commitment may vary by shift. Every shift we will need you to log in at the beginning and log out at the end. During your shift you will be asked to do various tasks like selecting your mood, doing time trial mini-games, doing memorization games etc. These mini-games are designed to test your mood, speed, and cognitive thinking.",
        "At any point you may withdraw from this research study. Upon withdrawing we will keep any data up to the point of your withdrawal. You may contact us if you would like your data completely removed from the research study."
    ]
    
    var i = 0;
    
    var consentSections: [ORKConsentSection] = []
    
    for sectionType in consentSectionTypes {
        let section = ORKConsentSection(type: sectionType)
        section.title = summaries[i]
        section.content = contents[i]
        i++;
        consentSections.append(section)
    }
    
    
    consentDocument.sections = consentSections
    
    consentDocument.addSignature(ORKConsentSignature(forPersonWithTitle: nil, dateFormatString: nil, identifier: "ConsentDocumentParticipantSignature"))
    
    return consentDocument
}