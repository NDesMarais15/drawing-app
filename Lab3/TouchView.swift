//
//  TouchView.swift
//  Lab3
//
//  Created by Nick DesMarais on 10/3/17.
//  Copyright © 2017 Nick DesMarais. All rights reserved.
//

import Foundation
import UIKit

class TouchView: UIView {
    
    var currentLine : [CGPoint]? {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var lines:[Line] = [] {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var lastClear:[Line] = []
    var currentColor : UIColor
    var thickness : CGFloat
    var rainbow : Bool
    
    override init(frame: CGRect) {
        currentColor = UIColor.black
        thickness = 5.0
        rainbow = false
        super.init(frame: frame)
        backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        currentColor = UIColor.black
        thickness = 5.0
        rainbow = false
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        for line in lines {
            drawLine(line)
        }
        if (currentLine != nil) {
            if (Helpers.checkForTap(points: currentLine!)) {
                let path = Helpers.createDot(points: currentLine!, width: thickness/2.0)
                let newLine = Line(color: currentColor, path: path, isDot: true)
                path.lineWidth = thickness/2.0
                drawLine(newLine)
            }
            else {
                let path = Helpers.createQuadPath(points: currentLine!)
                let newLine = Line(color: currentColor, path: path, isDot: false)
                path.lineWidth = thickness
                drawLine(newLine)
            }
        }
    }
    
    func drawLine(_ line: Line) {
        line.color.setStroke()
        line.path.stroke()
        if line.isDot {
            line.color.setFill()
            line.path.fill()
        }
    }
}
