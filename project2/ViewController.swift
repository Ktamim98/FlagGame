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
        
      let left1 = UIBarButtonItem(title: "Score", style: .plain, target: self, action: #selector(showScore))
      let left2 = UIBarButtonItem(title: "🔔", style: .plain, target: self, action: #selector(scheduleLocal))
        

            navigationItem.leftBarButtonItems = [left1, left2]
        
        
        let right1 = UIBarButtonItem(title: "High Score: \(highScore)", style: .plain, target: self, action: nil)
//        let right2 = UIBarButtonItem(title: "register", style: .plain, target: self, action: #selector(registerLocal))
        
        
            navigationItem.rightBarButtonItems = [right1]
        
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
        
        UIView.animate(withDuration: 0.1, animations: {
                sender.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            }) { finished in
                UIView.animate(withDuration: 0.1) {
                    sender.transform = CGAffineTransform.identity
                }
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
    
    @objc func scheduleLocal(){
           
           
           
           
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .badge, .sound]){
            (granted, error) in
            if granted {
                print("noice!")
            }else{
                    print("oh, no!")
                }
            }
           center.removeAllPendingNotificationRequests()
           
           let content = UNMutableNotificationContent()
           content.title = "let's back to game"
           content.body = "since it's been 5 sec your not playing.stop what are you doing right now and play the game you idot"
           content.categoryIdentifier = "alarm"
           content.sound = UNNotificationSound.default
           
           
          
           let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
          
           
           let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
           center.add(request)
           
           
       }
//    @objc func registerLocal(){
//
//            let center = UNUserNotificationCenter.current()
//
//            center.requestAuthorization(options: [.alert, .badge, .sound]){
//                (granted, error) in
//                if granted {
//                    print("noice!")
//                }else{
//                        print("oh, no!")
//                    }
//                }
//
//        }

    
    
    }





