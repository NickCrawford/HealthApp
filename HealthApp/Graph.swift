//
//  Graph.swift
//  HealthApp
//
//  Created by Nicholas Crawford on 2/11/16.
//  Copyright © 2016 Nick Crawford. All rights reserved.
//

import Foundation
import ResearchKit

class LineGraphDataSource: NSObject, ORKGraphChartViewDataSource {
    
    var plotPoints =
    [
        [
            ORKRangedPoint(value: 10),
            ORKRangedPoint(value: 20),
            ORKRangedPoint(value: 25),
            ORKRangedPoint(),
            ORKRangedPoint(value: 30),
            ORKRangedPoint(value: 40),
        ],
        [
            ORKRangedPoint(value: 10),
            ORKRangedPoint(value: 20),
            ORKRangedPoint(value: 25),
            ORKRangedPoint(),
            ORKRangedPoint(value: 30),
            ORKRangedPoint(value: 40),
        ]
    ]
    
    func numberOfPlotsInGraphChartView(graphChartView: ORKGraphChartView) -> Int {
        return plotPoints.count
    }
    
    func graphChartView(graphChartView: ORKGraphChartView, pointForPointIndex pointIndex: Int, plotIndex: Int) -> ORKRangedPoint {
        return plotPoints[plotIndex][pointIndex]
    }
    
    func graphChartView(graphChartView: ORKGraphChartView, numberOfPointsForPlotIndex plotIndex: Int) -> Int {
        return plotPoints[plotIndex].count
    }
    
    func maximumValueForGraphChartView(graphChartView: ORKGraphChartView) -> CGFloat {
        return 70
    }
    
    func minimumValueForGraphChartView(graphChartView: ORKGraphChartView) -> CGFloat {
        return 0
    }
    
    func graphChartView(graphChartView: ORKGraphChartView, titleForXAxisAtPointIndex pointIndex: Int) -> String? {
        return "\(pointIndex + 1)"
    }
}
