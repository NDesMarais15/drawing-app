//
//  Helpers.swift
//  Lab3
//
//  Created by Nick DesMarais on 10/3/17.
//  Copyright © 2017 Nick DesMarais. All rights reserved.
//

import Foundation
import UIKit

class Helpers {
    
    static func midpoint (first: CGPoint, second: CGPoint) -> (CGPoint) {
        var midpoint = CGPoint()
        midpoint.x = (first.x + second.x) / 2
        midpoint.y = (first.y + second.y) / 2
        return midpoint
    }
    
    static func createQuadPath(points: [CGPoint]) -> UIBezierPath {
        let path = UIBezierPath()
        if points.count < 2 { return path }
        let firstPoint = points[0]
        let secondPoint = points[1]
        let firstMidpoint = midpoint(first: firstPoint, second: secondPoint)
        path.move(to: firstPoint)
        path.addLine(to: firstMidpoint)
        for index in 1 ..< points.count-1 {
            let currentPoint = points[index]
            let nextPoint = points[index + 1]
            let midPoint = midpoint(first: currentPoint, second: nextPoint)
            path.addQuadCurve(to: midPoint, controlPoint: currentPoint)
        }
        guard let lastLocation = points.last else { return path }
        path.addLine(to: lastLocation)
        path.lineCapStyle = .round
        return path
    }
    
    static func checkForTap(points: [CGPoint]) -> Bool {
        for point in points {
            if abs(points[0].x - point.x) > 0.5 || abs(points[0].y - point.y) > 0.5 {
                return false
            }
        }
        return true
    }
    
    static func createDot(points: [CGPoint], width: CGFloat) ->
        UIBezierPath {
        let path = UIBezierPath()
        path.addArc(withCenter: points[0], radius: width, startAngle: 0, endAngle: CGFloat(Float.pi * 2), clockwise: true)
        return path
    }
    
    static func randomColor() -> UIColor {
        let rand: Double = drand48()
        if (rand <= 1.0/6.0) {
            return UIColor.red
        }
        else if (rand <= 2.0/6.0) {
            return UIColor.blue
        }
        else if (rand <= 3.0/6.0) {
            return UIColor.green
        }
        else if (rand <= 4.0/6.0) {
            return UIColor.yellow
        }
        else if (rand <= 5.0/6.0) {
            return UIColor.purple
        }
        else {
            return UIColor.black
        }
    }
}
