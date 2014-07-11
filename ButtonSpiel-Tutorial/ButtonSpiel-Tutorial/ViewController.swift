//
//  ViewController.swift
//  ButtonSpiel-Tutorial
//
//  Created by Benjamin Herzog on 09.07.14.
//  Erstellt für den YouTube Kanal swiftdetut unter https://www.youtube.com/user/swiftdetut
//  Copyright (c) 2014 Benjamin Herzog. All rights reserved.
//

import UIKit

// Anzahl der Taps, bis das Spiel abbricht
let ANZAHL_TAPS = 5
// Zufällig gewählte Zahl, die das Label identifizieren soll
let LABEL_TAG = 8

class ViewController: UIViewController {
    
    // Button, um ein neues Spiel zu starten
    let newGameButton = UIButton()
    // Button, mit dem gespielt wird
    var button = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    // Zählt mit, wie oft schon richtig getippt wurde
    var zaehler = 0
    
    // Zeitdifferenz stellt nach einem Spiel die Leistung dar
    var startTime = NSDate.date()
    var endTime = NSDate.date()
    
    override func viewDidLoad() {
        // Position, Titel, Hintergrundfarbe und Action zuweisen
        newGameButton.frame = CGRect(x: view.frame.size.width/2 - 200/2, y: view.frame.size.height/2 - 200/2, width: 200, height: 200)
        newGameButton.setTitle("Neues Spiel", forState: .Normal)
        newGameButton.backgroundColor = UIColor.blueColor()
        newGameButton.addTarget(self, action: "newGameButtonPressed:", forControlEvents: .TouchUpInside)
        view.addSubview(newGameButton)
        
        // Spielbutton ausblenden
        button.hidden = true
        
        // Button rundgestalten (// am Anfang entfernen, um dies zu aktivieren)
        //button.layer.cornerRadius = button.frame.size.height/2
        view.addSubview(button)
    }
    
    // Methode, die aufgerufen wird, wenn ein Spiel gestartet werden soll
    func newGameButtonPressed(sender: UIButton!) {
        // sender ist in dem Fall immer der newGameButton
        sender.hidden = true
        // Das Label mit dem Ergebnis entfernen, wenn es denn vorhanden ist
        view.viewWithTag(LABEL_TAG)?.removeFromSuperview()
        // Den Spiel-Button an eine zufällige Position auf dem Display bewegen
        let (x,y) = randomPositionForButton()
        button.center = CGPoint(x: x, y: y)
        button.backgroundColor = randomBackgroundColorForButton()
        button.hidden = false
        button.addTarget(self, action: "buttonPressed:", forControlEvents: .TouchUpInside)
        // Startzeit setzen
        startTime = NSDate.date()
    }
    
    func buttonPressed(sender: UIButton!) {
        // Zähler für Treffer erhöhen, um Fertigstellung feststellen zu können
        zaehler++
        // Wenn die nötigen Taps für Beenden des Spiels erreicht wurden
        if zaehler >= ANZAHL_TAPS {
            endTime = NSDate.date()
            zaehler = 0
            button.hidden = true
            newGameButton.hidden = false
            
            // Zeitdifferenz zwischen Anfang und Ende des Spiels feststellen
            let labelText = NSString(format: "Zeit: %.2f Sekunden", Float(endTime.timeIntervalSinceDate(startTime)))
            
            // UILabel für die Ausgabe erstellen und richtig positionieren und einrichten
            var label = UILabel(frame: CGRect(x: 0, y: 0, width: 250, height: 50))
            label.font = UIFont(name: "Helvetica Neue", size: 25)
            label.text = labelText
            label.textColor = UIColor.redColor()
            label.textAlignment = .Center
            label.center = CGPoint(x: view.center.x, y: view.frame.size.height*0.9)
            label.tag = LABEL_TAG
            view.addSubview(label)
        }
        // Wenn das Spiel noch nicht beendet wurde
        else {
            // Neue zufällige Position für die Spiel Button berechnen
            let (x,y) = randomPositionForButton()
            button.center = CGPoint(x: x, y: y)
            button.backgroundColor = randomBackgroundColorForButton()
        }
    }
    
    // Zufällige Position für den Spiel Button generieren
    func randomPositionForButton() -> (x: Int, y: Int) {
        let randomX = random() % (Int(view.frame.size.width) - Int(button.frame.size.width))
        let randomY = random() % (Int(view.frame.size.height) - Int(button.frame.size.height))
        return (randomX + Int(button.frame.size.width)/2, randomY + Int(button.frame.size.height)/2)
    }
    
    // Zufällige Farbe für den Button erstellen
    func randomBackgroundColorForButton() -> UIColor {
        let redValue = CGFloat(rand() % 255) / 255
        let greenValue = CGFloat(rand() % 255) / 255
        let blueValue = CGFloat(rand() % 255) / 255
        
        return UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: 1)
    }


}