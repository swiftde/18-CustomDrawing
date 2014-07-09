//
//  ViewController.swift
//  ButtonSpiel-Tutorial
//
//  Created by Benjamin Herzog on 09.07.14.
//  Copyright (c) 2014 Benjamin Herzog. All rights reserved.
//

import UIKit

let ANZAHL_TAPS = 5
let LABEL_TAG = 8

class ViewController: UIViewController {
                            
    let newGameButton = UIButton()
    var button = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    var zaehler = 0
    
    var startTime = NSDate.date()
    var endTime = NSDate.date()
    
    override func viewDidLoad() {
        newGameButton.frame = CGRect(x: view.frame.size.width/2 - 200/2, y: view.frame.size.height/2 - 200/2, width: 200, height: 200)
        newGameButton.setTitle("Neues Spiel", forState: .Normal)
        newGameButton.backgroundColor = UIColor.blueColor()
        newGameButton.addTarget(self, action: "newGameButtonPressed:", forControlEvents: .TouchUpInside)
        view.addSubview(newGameButton)
        
        button.backgroundColor = UIColor.blackColor()
        button.hidden = true
        view.addSubview(button)
    }
    
    func newGameButtonPressed(sender: UIButton!) {
        sender.hidden = true
        view.viewWithTag(LABEL_TAG)?.removeFromSuperview()
        let (x,y) = randomPositionForButton()
        button.center = CGPoint(x: x, y: y)
        button.backgroundColor = randomBackgroundColorForButton()
        button.hidden = false
        button.addTarget(self, action: "buttonPressed:", forControlEvents: .TouchUpInside)
        startTime = NSDate.date()
    }
    
    func buttonPressed(sender: UIButton!) {
        zaehler++
        if zaehler >= ANZAHL_TAPS {
            endTime = NSDate.date()
            zaehler = 0
            button.hidden = true
            newGameButton.hidden = false
            let labelText = NSString(format: "Zeit: %.2f Sekunden", Float(endTime.timeIntervalSinceDate(startTime)))
            var label = UILabel(frame: CGRect(x: 0, y: 0, width: 250, height: 50))
            label.font = UIFont(name: "Helvetica Neue", size: 25)
            label.text = labelText
            label.textColor = UIColor.redColor()
            label.textAlignment = .Center
            label.center = CGPoint(x: view.center.x, y: view.frame.size.height*0.9)
            label.tag = LABEL_TAG
            view.addSubview(label)
        }
        else {
            let (x,y) = randomPositionForButton()
            button.center = CGPoint(x: x, y: y)
            button.backgroundColor = randomBackgroundColorForButton()
        }
    }
    
    func randomPositionForButton() -> (x: Int, y: Int) {
        let randomX = random() % (Int(view.frame.size.width) - Int(button.frame.size.width))
        let randomY = random() % (Int(view.frame.size.height) - Int(button.frame.size.height))
        return (randomX + Int(button.frame.size.width)/2, randomY + Int(button.frame.size.height)/2)
    }
    
    func randomBackgroundColorForButton() -> UIColor {
        let redValue = CGFloat(rand() % 255) / 255
        let greenValue = CGFloat(rand() % 255) / 255
        let blueValue = CGFloat(rand() % 255) / 255
        
        return UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: 1)
    }


}