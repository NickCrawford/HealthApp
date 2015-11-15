//
//  ORKJugglingStepViewController.swift
//  HealthApp
//
//  Created by Nicholas Crawford on 11/15/15.
//  Copyright © 2015 Nick Crawford. All rights reserved.
//
import UIKit
import ResearchKit
import Foundation


class DemoView: UIView {
   
    var balls: [CGPoint] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        balls = [CGPointMake(self.bounds.width/2, self.bounds.height/3)]
        
        let summaryLabel = UILabel()
        summaryLabel.translatesAutoresizingMaskIntoConstraints = false
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(rect: CGRect) {
        var startAngle: Float = Float(2 * M_PI)
        var endAngle: Float = 0.0
        
        // Drawing code
        // Set the radius
        let strokeWidth = 3.0
        let radius = CGFloat((CGFloat(self.frame.size.width) - CGFloat(strokeWidth)) / 12)
        
        // Get the context
        var context = UIGraphicsGetCurrentContext()
        
        // Find the middle of the circle
        let center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2)
        
        // Set the stroke color
        CGContextSetStrokeColorWithColor(context,  UIColor.blueColor().CGColor)
        
        // Set the line width
        CGContextSetLineWidth(context, CGFloat(strokeWidth))
        
        // Set the fill color (if you are filling the circle)
        CGContextSetFillColorWithColor(context, UIColor.clearColor().CGColor)
        
        // Rotate the angles so that the inputted angles are intuitive like the clock face: the top is 0 (or 2π), the right is π/2, the bottom is π and the left is 3π/2.
        // In essence, this appears like a unit circle rotated π/2 anti clockwise.
        startAngle = startAngle - Float(M_PI_2)
        endAngle = endAngle - Float(M_PI_2)
        
        // Draw the arc around the circle
        CGContextAddArc(context, center.x, center.y, CGFloat(radius), CGFloat(startAngle), CGFloat(endAngle), 0)
        
        // Draw the arc
        CGContextDrawPath(context, .Stroke) // or kCGPathFillStroke to fill and stroke the circle

    }
    
    
}

class JugglingStepViewController : ORKActiveStepViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red:1.0, green:1.0, blue:1.0, alpha:1.0)
        
        let demoView = DemoView(frame: self.view.bounds)
        demoView.backgroundColor = UIColor(red:1.0, green:0.0, blue:1.0, alpha:1.0)
        self.customView = demoView
        
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[demoView]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["demoView": demoView]))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[demoView]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["demoView": demoView]))
    }
    
}