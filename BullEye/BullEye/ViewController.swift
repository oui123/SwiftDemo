//
//  ViewController.swift
//  BullEye
//
//  Created by ouis on 16/4/8.
//  Copyright © 2016年 ouis. All rights reserved.
//

import UIKit
import QuartzCore
class ViewController: UIViewController {
    var currentValue = 50
    var targetValue = 0
    var score = 0
    var round = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        startNewGame()
        updateLabels()
        
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, forState: .Normal)
        
        let thumbImageHighted = UIImage(named: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighted, forState: .Highlighted)
        
        let insets = UIEdgeInsetsMake(0, 14, 0, 14)
        
        if let trackLeftImage = UIImage(named: "SliderTrackLeft"){
           let trackLeftResizable = trackLeftImage.resizableImageWithCapInsets(insets)
            slider.setMinimumTrackImage(trackLeftResizable, forState: .Normal)
        }
        
        if let trackRightImage = UIImage(named: "SliderTrackRight"){
            let trackRightResizable = trackRightImage.resizableImageWithCapInsets(insets)
            slider.setMaximumTrackImage(trackRightResizable, forState: .Normal)
        }
    }
    func startNewRound() {
        round += 1
        currentValue = lroundf(slider.value)
        targetValue = 1 + Int(arc4random_uniform(100))
        slider.value = Float(currentValue)
        
    }
    func updateLabels() {
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }
    
    func startNewGame() {
        score = 0
        round = 0
        startNewRound()
    }
    
    @IBAction func showAlert () {
        //        var difference: Int
        //        if currentValue > targetValue {
        //            difference = currentValue - targetValue
        //        } else if targetValue > currentValue {
        //            difference = targetValue - currentValue
        //        } else {
        //            difference = 0
        //        }
        
        //        var difference = currentValue - targetValue
        //        if difference < 0 {
        //            difference = difference * -1
        //        }
        
        //        let meesage = "The value of the slider is :\(currentValue)"
        //                    + "\nThe target value is \(targetValue)"
        //                    + "\nThe difference is \(difference)"
        
        let difference = abs(targetValue - currentValue)
        var points = 100 - difference
        
        
        let title: String
        if difference == 0 {
            title = "Perfect!"
            points += 100
        } else if difference < 5 {
            title = "You almost had it!"
            if difference == 1 {
                points += 50
            }
        } else if difference < 10
        {
            title = "Pretty good!"
        } else {
            title = "Not even close..."
        }
        
        score += points
        
        
        let meesage = "You scored \(points) points"
        let alert = UIAlertController(title: title, message: meesage, preferredStyle: .Alert)
        let action = UIAlertAction(title: "OK", style: .Default, handler: { action in
//            self.startNewRound()
//            self.updateLabels()
        })
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
        startNewRound()
        updateLabels()
        
    }
    
    @IBAction func sliderMoved(slider: UISlider) {
        print("The value of the slider is now: \(slider.value)")
        currentValue = lroundf(slider.value)
    }
    
    @IBAction func startOver() {
        startNewGame()
        updateLabels()
        
        
        let transition = CATransition()
        transition.type = kCATransitionFade
        transition.duration = 1
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        view.layer.addAnimation(transition, forKey: nil)
        
        
        
    }

    
    
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

