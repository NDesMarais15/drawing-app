//
//  ViewController.swift
//  Lab3
//
//  Created by Nick DesMarais on 10/3/17.
//  Copyright © 2017 Nick DesMarais. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var touchView: TouchView!
    var currentPoints: [CGPoint] = []
    var thickness : CGFloat = 5.0
    var lineMode : Bool = false
    
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var lineModeButton: UIButton!
    
    @IBAction func undoButtonPressed(_ sender: Any) {
        if touchView.lines.count != 0 {
            touchView.lines.removeLast()
        }
        touchView.currentLine = nil
    }
    
    @IBAction func clearButtonPressed(_ sender: Any) {
        if touchView.lines.count != 0 {
            touchView.lastClear = touchView.lines
        }
        touchView.lines = []
        touchView.currentLine = nil
    }
    
    @IBAction func recoverButtonPressed(_ sender: Any) {
        touchView.currentLine = nil
        swap(&touchView.lines, &touchView.lastClear)
    }
    
    @IBAction func sliderMoved(_ sender: Any) {
        thickness = CGFloat((slider.value*10.0) + 0.1)
        touchView.thickness = CGFloat((slider.value*10.0) + 0.1)
    }
    
    @IBAction func redPressed(_ sender: Any) {
        touchView.rainbow = false
        touchView.currentColor = UIColor.red
    }
    
    @IBAction func bluePressed(_ sender: Any) {
        touchView.rainbow = false
        touchView.currentColor = UIColor.blue
    }
    
    @IBAction func greenPressed(_ sender: Any) {
        touchView.rainbow = false
        touchView.currentColor = UIColor.green
    }
    
    @IBAction func yellowPressed(_ sender: Any) {
        touchView.rainbow = false
        touchView.currentColor = UIColor.yellow
    }
    
    @IBAction func purplePressed(_ sender: Any) {
        touchView.rainbow = false
        touchView.currentColor = UIColor.purple
    }
    
    @IBAction func blackPressed(_ sender: Any) {
        touchView.rainbow = false
        touchView.currentColor = UIColor.black
    }
    
    @IBAction func rainbowPressed(_ sender: Any) {
        touchView.rainbow = true
    }
    
    @IBAction func lineModePressed(_ sender: Any) {
        lineMode = !lineMode
        if lineMode {
            lineModeButton.setTitle("Draw Mode", for: .normal)
        }
        else {
            lineModeButton.setTitle("Line Mode", for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touchPoint = touches.first?.location(in: view) else { return }
        
        if touchView.rainbow {
            touchView.currentColor = Helpers.randomColor()
        }
        currentPoints.append(touchPoint)
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !lineMode {
            guard let touchPoint = touches.first?.location(in: view) else { return }
            currentPoints.append(touchPoint)
            touchView.currentLine = currentPoints
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touchPoint = touches.first?.location(in: view) else { return }
        currentPoints.append(touchPoint)
        touchView.currentLine = currentPoints
        if Helpers.checkForTap(points: currentPoints) {
            let path = Helpers.createDot(points: currentPoints, width: thickness/2.0)
            path.lineWidth = thickness/2.0
            let line = Line(color: touchView.currentColor, path: path, isDot: true)
            touchView.lines.append(line)
            currentPoints = []
        }
        else {
            let path = Helpers.createQuadPath(points: currentPoints)
            path.lineWidth = thickness
            let line = Line(color: touchView.currentColor, path: path, isDot: false)
            touchView.lines.append(line)
            currentPoints = []
        }
    }
}

