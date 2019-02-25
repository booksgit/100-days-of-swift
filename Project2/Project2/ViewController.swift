//
//  ViewController.swift
//  Project2
//
//  Created by julie on 23/02/2019.
//  Copyright © 2019 booksgit. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var numQuestionsAsked = 0
    var score = 0
    var correctAnswer = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // We could do countries.append("estonia") for each country
        countries += ["estonia", "france", "germany", "ireland", "italy",
        "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        //button1.layer.borderColor = UIColor(red: 1.0, green: 0.2, blue: 0.4, alpha: 1.0).cgColor
        // .layer is a CA - core animation layer that is lower level than UIStuff classes
        // UIImage --- UIcolors
        // CA layer --- cgColor
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        askQuestion()
    }

    func askQuestion(action: UIAlertAction! = nil)
    {
        // .shuffle() shuffle in place
        // .shuffled() shuffle and return a new array
        
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        //title = countries[correctAnswer].uppercased()
        title = "   SCORE \(score)/\(numQuestionsAsked)        \(countries[correctAnswer].uppercased())"
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        
        numQuestionsAsked += 1
        
        if sender.tag == correctAnswer
        {
            title = "Correct"
            score += 1
        }
        else
        {
            title = "Wrong!\n That’s the flag of \(countries[sender.tag])"
            score -= 1
        }
        
        // for UIAlertController
        // .alert --- inform the user about situation changes --- pop up message box over the center of the screen
        // .actionSheet --- chose for a range of options --- slides options up from the bottom
        
        // for UIAlertAction
        // .default .cancel .destroy
        
        /* from the transcript:
            Warning: We must use askQuestion and not askQuestion(). If you use the former, it means "here's the name of the method to run," but if you use the latter it means "run the askQuestion() method now, and it will tell you the name of the method to run."
        */
        if numQuestionsAsked == 10
        {
            let ac = UIAlertController(title: title, message: "Your final score is \(score)/\(numQuestionsAsked)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Play Again", style: .default, handler: askQuestion))
            
            present(ac, animated: true)
            
            numQuestionsAsked = 0
            score = 0
            
        }
        
        if numQuestionsAsked < 10 // basically an else
        // but precising the condition makes it clearer for me when I read it
        {
            let ac = UIAlertController(title: title, message: "Your score is \(score)/\(numQuestionsAsked)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            
            present(ac, animated: true)
        }

    }
    
}

