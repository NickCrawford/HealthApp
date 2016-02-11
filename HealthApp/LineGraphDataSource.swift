import ResearchKit

class LineGraphDataSource: NSObject, ORKGraphChartViewDataSource {
    
    var plotPoints =
    [
        [
            ORKRangedPoint(value: 30),
            ORKRangedPoint(value: 25),
            ORKRangedPoint(value: 10),
            ORKRangedPoint(value: 25),
            ORKRangedPoint(value: 30),
            ORKRangedPoint(value: 60),
            ORKRangedPoint(value: 30),
            ORKRangedPoint(value: 10),
        ]
    ]
    
    // Required methods
    
    func graphChartView(graphChartView: ORKGraphChartView, pointForPointIndex pointIndex: Int, plotIndex: Int) -> ORKRangedPoint {
        
        return plotPoints[plotIndex][pointIndex]
    }
    
    func graphChartView(graphChartView: ORKGraphChartView, numberOfPointsForPlotIndex plotIndex: Int) -> Int {
        return plotPoints[plotIndex].count
    }
    
    // Optional methods
    
    // Returns the number of points to the graph chart view
    func numberOfPlotsInGraphChartView(graphChartView: ORKGraphChartView) -> Int {
        return plotPoints.count
    }
    
    // Sets the maximum value on the y axis
    func maximumValueForGraphChartView(graphChartView: ORKGraphChartView) -> CGFloat {
        return 100
    }
    
    // Sets the minimum value on the y axis
    func minimumValueForGraphChartView(graphChartView: ORKGraphChartView) -> CGFloat {
        return 0
    }
    
    // Provides titles for x axis
    func graphChartView(graphChartView: ORKGraphChartView, titleForXAxisAtPointIndex pointIndex: Int) -> String? {
        switch pointIndex {
        case 0:
            return "12am"
        case 1:
            return "2"
        case 2:
            return "4"
        case 3:
            return "6"
        case 4:
            return "8"
        case 5:
            return "10"
        case 6:
            return "12pm"
        case 7:
            return "2"
        case 8:
            return "4"
        case 9:
            return "6"
        case 10:
            return "8"
        case 11:
            return "10"
        default:
            return "Day \(pointIndex + 1)"
        }
    }
    
    // Returns the color for the given plot index
    func graphChartView(graphChartView: ORKGraphChartView, colorForPlotIndex plotIndex: Int) -> UIColor {
        if plotIndex == 0 {
            return UIColor.blueColor()
        }
        return UIColor.blueColor()

    }
}