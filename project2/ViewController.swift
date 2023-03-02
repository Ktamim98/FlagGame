//
//  ViewController.swift
//  project2
//
//  Created by Tamim Khan on 28/1/23.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAns = 0
    var highScore = 0
    

    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Score", style: .plain, target: self, action: #selector(showScore))
        


        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "High Score: \(highScore)", style: .plain, target: self, action: nil)

        
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        
        askQuestions()
        
        
        
        let defaults = UserDefaults.standard
            if let loadedHighScore = defaults.value(forKey: "highScore") as? Int {
                highScore = loadedHighScore
                navigationItem.rightBarButtonItem?.title = "High Score: \(highScore)"
                print("Successfully loaded high score! It is \(highScore)!")
            } else {
                print("Failed to load high score or score not yet saved. High score is \(highScore)...")
            }
        
        
        
        
    }
    
    func askQuestions(action : UIAlertAction! = nil) {
        
        countries.shuffle()
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        correctAns = Int.random(in: 0...2)
        
       let upperCasedCountry = countries[correctAns].uppercased()
        
       
        title = upperCasedCountry
        
       
        
    }

    func startNewGame(action: UIAlertAction) {
            score = 0
        let defaults = UserDefaults.standard
            defaults.set(highScore, forKey: "highScore")
            navigationItem.rightBarButtonItem?.title = "High Score: \(highScore)"
            
            
            askQuestions()
        
        }

    
    @IBAction func buttonTapped(_ sender: UIButton) {
        
        var title: String
        
        if sender.tag == correctAns{
            title = "Correct"
            score += 1
            
        } else {
            title = "Wrong! That's the flag of \(countries[sender.tag].uppercased())"
                score -= 1
            }
        
        
       if score >= 20 {
            let finalAlertController = UIAlertController(title: "Game over!", message: "Your score is \(score).", preferredStyle: .alert)
            finalAlertController.addAction(UIAlertAction(title: "Start new game!", style: .default, handler: startNewGame))
            present(finalAlertController, animated: true)
        
        }else if score > highScore{
            highScore = score
            let highScoreAlertController = UIAlertController(title: "Well Done!", message: "you have made a new high score", preferredStyle: .alert)
            highScoreAlertController.addAction(UIAlertAction(title: "continue", style: .default, handler: nil))
            present(highScoreAlertController, animated: true)
            save()
            askQuestions()
            navigationItem.rightBarButtonItem?.title = "High Score: \(highScore)"
           

        }else {
            let alertController = UIAlertController(title: title, message: "Your score is \(score).", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestions))
            present(alertController, animated: true)
        }
        
        }
    
    @objc func showScore(){
        let ScoreAlert = UIAlertController(title: "SCORE", message: "your score is \(score)", preferredStyle: .actionSheet)
        ScoreAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(ScoreAlert, animated: true)
    }
    
    
    
    func save() {
            let defaults = UserDefaults.standard
            
            do {
                defaults.set(highScore, forKey: "highScore")
                print("Successfully saved score!")
            }
        }

    
    
    }





