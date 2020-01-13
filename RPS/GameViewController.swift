//
//  ViewController.swift
//  RPS
//
//  Created by Marcin Bartminski on 07/01/2020.
//  Copyright © 2020 Marcin Bartminski. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var rockButton: UIButton!
    @IBOutlet weak var paperButton: UIButton!
    @IBOutlet weak var scissorsButton: UIButton!
    
    @IBOutlet weak var pauseButton: UIButton!
    
    @IBOutlet weak var playerPointsLabel: UILabel!
    @IBOutlet weak var botPointsLabel: UILabel!
    
    @IBOutlet weak var playerImageView: UIImageView!
    @IBOutlet weak var botImageView: UIImageView!
    @IBOutlet weak var backButtonView: UIView!
    
    var playerChoice: Int?
    var botChoice: Int?
    
    var playerPoints = 0
    var botPoints = 0
    
    var mode = "dupa"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rockButton.layer.cornerRadius = rockButton.frame.width/2
        paperButton.layer.cornerRadius = paperButton.frame.width/2
        scissorsButton.layer.cornerRadius = scissorsButton.frame.width/2
        
        playerPointsLabel.text = "\(playerPoints)"
        playerPointsLabel.alpha = 0
        botPointsLabel.text = "\(botPoints)"
        botPointsLabel.alpha = 0
        
        playerImageView.alpha = 0
        botImageView.alpha = 0
        
        backButtonView.layer.cornerRadius = backButtonView.frame.size.height/2
        backButtonView.backgroundColor = .systemGray6
        backButtonView.alpha = 0
        
        print(mode)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        backButtonView.alpha = 1
        backButtonView.center.y = backButtonView.center.y + 150
        
        UIView.animate(withDuration: 0.3, animations: {
            self.backButtonView.center.y = self.backButtonView.center.y - 150
            self.playerPointsLabel.alpha = 1
            self.botPointsLabel.alpha = 1
        })
        
    }
    
    
    // MARK: - Button Pressed Functions
    
    @IBAction func rockButtonPressedDown(_ sender: Any) {
        UIView.animate(withDuration: 0.2) {
            self.rockButton.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }
        
        botChoice = Int.random(in: 1...3)
    }
    @IBAction func rockButtonPressed(_ sender: Any) {
        UIView.animate(withDuration: 0.2) {
            self.rockButton.transform = .identity
        }
        playerChoice = 1
        
        rockButton.isEnabled = false
        paperButton.isEnabled = false
        scissorsButton.isEnabled = false
        
        battleBegin(playerChoice: playerChoice!, botChoice: botChoice!)
    }
    
    @IBAction func paperButtonPressedDown(_ sender: Any) {
        UIView.animate(withDuration: 0.2) {
            self.paperButton.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }
        botChoice = Int.random(in: 1...3)
    }
    @IBAction func paperButtonPressed(_ sender: Any) {
        UIView.animate(withDuration: 0.2) {
            self.paperButton.transform = .identity
        }
        playerChoice = 2
        
        rockButton.isEnabled = false
        paperButton.isEnabled = false
        scissorsButton.isEnabled = false
        
        battleBegin(playerChoice: playerChoice!, botChoice: botChoice!)
    }
    
    @IBAction func scissorsButtonPressedDown(_ sender: Any) {
        UIView.animate(withDuration: 0.2) {
            self.scissorsButton.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }
        botChoice = Int.random(in: 1...3)
    }
    @IBAction func scissorsButtonPressed(_ sender: Any) {
        UIView.animate(withDuration: 0.2) {
            self.scissorsButton.transform = .identity
        }
        playerChoice = 3
        
        rockButton.isEnabled = false
        paperButton.isEnabled = false
        scissorsButton.isEnabled = false
        
        battleBegin(playerChoice: playerChoice!, botChoice: botChoice!)
    }
    
    @IBAction func pauseButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "pause", sender: nil)
    }
    
    
    // MARK: - Battle Functions
    
    func battleBegin(playerChoice: Int, botChoice: Int) {
        if playerChoice == 1 && botChoice == 1 {
            playerImageView.image = UIImage(named: "rock1")
            botImageView.image = UIImage(named: "rock1")
            tie()
        } else if playerChoice == 1 && botChoice == 2 {
            playerImageView.image = UIImage(named: "rock1")
            botImageView.image = UIImage(named: "paper1")
            botWins()
        } else if playerChoice == 1 && botChoice == 3 {
            playerImageView.image = UIImage(named: "rock1")
            botImageView.image = UIImage(named: "scissors1")
            playerWins()
        } else if playerChoice == 2 && botChoice == 1 {
            playerImageView.image = UIImage(named: "paper1")
            botImageView.image = UIImage(named: "rock1")
            playerWins()
        } else if playerChoice == 2 && botChoice == 2 {
            playerImageView.image = UIImage(named: "paper1")
            botImageView.image = UIImage(named: "paper1")
            tie()
        } else if playerChoice == 2 && botChoice == 3 {
            playerImageView.image = UIImage(named: "paper1")
            botImageView.image = UIImage(named: "scissors1")
            botWins()
        } else if playerChoice == 3 && botChoice == 1 {
            playerImageView.image = UIImage(named: "scissors1")
            botImageView.image = UIImage(named: "rock1")
            botWins()
        } else if playerChoice == 3 && botChoice == 2 {
            playerImageView.image = UIImage(named: "scissors1")
            botImageView.image = UIImage(named: "paper1")
            playerWins()
        } else if playerChoice == 3 && botChoice == 3 {
            playerImageView.image = UIImage(named: "scissors1")
            botImageView.image = UIImage(named: "scissors1")
            tie()
        }
    }
    
    func playerWins() {
        UIView.animate(withDuration: 0.5, animations: {
            self.playerImageView.alpha = 1
            self.botImageView.alpha = 1
        }, completion: { (_) in
            UIView.animate(withDuration: 0.5, animations: {
                self.playerImageView.center.y = self.playerImageView.center.y - 125
                self.playerImageView.center.x = self.view.center.x
            }, completion: { (_) in
                UIView.animate(withDuration: 0.3, animations: {
                    self.botImageView.transform = CGAffineTransform(rotationAngle: 0.5)
                }, completion: { (_) in
                    UIView.animate(withDuration: 0.3, animations: {
                        self.botImageView.transform = .identity
                    }, completion: { (_) in
                        UIView.animate(withDuration: 0.5, animations: {
                            self.playerImageView.alpha = 0
                            self.botImageView.alpha = 0
                        }, completion: { (_) in
                            if self.mode == "to3" {
                                self.to3CheckWhoWon()
                            }
                        })
                        self.playerPoints += 1
                        self.playerPointsLabel.text = "\(self.playerPoints)"
                        
                        self.rockButton.isEnabled = true
                        self.paperButton.isEnabled = true
                        self.scissorsButton.isEnabled = true
                    })
                })
            })
        })
    }
    
    func botWins() {
        UIView.animate(withDuration: 0.5, animations: {
            self.playerImageView.alpha = 1
            self.botImageView.alpha = 1
        }, completion: { (_) in
            UIView.animate(withDuration: 0.5, animations: {
                self.botImageView.center.y = self.botImageView.center.y + 125
                self.botImageView.center.x = self.view.center.x
            }, completion: { (_) in
                UIView.animate(withDuration: 0.3, animations: {
                    self.playerImageView.transform = CGAffineTransform(rotationAngle: -0.5)
                }, completion: { (_) in
                    UIView.animate(withDuration: 0.3, animations: {
                        self.playerImageView.transform = .identity
                    }, completion: { (_) in
                        UIView.animate(withDuration: 0.5, animations: {
                            self.playerImageView.alpha = 0
                            self.botImageView.alpha = 0
                        }, completion: { (_) in
                            if self.mode == "to3" {
                                self.to3CheckWhoWon()
                            }
                        })
                        self.botPoints += 1
                        self.botPointsLabel.text = "\(self.botPoints)"
                        
                        self.rockButton.isEnabled = true
                        self.paperButton.isEnabled = true
                        self.scissorsButton.isEnabled = true
                    })
                })
            })
        })
    }
    
    func tie() {
        UIView.animate(withDuration: 0.5, animations: {
            self.playerImageView.alpha = 1
            self.botImageView.alpha = 1
        }, completion: { (_) in
            UIView.animate(withDuration: 0.3, animations: {
                self.playerImageView.transform = CGAffineTransform(rotationAngle: -0.5)
                self.botImageView.transform = CGAffineTransform(rotationAngle: 0.5)
            }, completion: { (_) in
                UIView.animate(withDuration: 0.3, animations: {
                    self.playerImageView.transform = .identity
                    self.botImageView.transform = .identity
                }, completion: { (_) in
                    UIView.animate(withDuration: 0.5, animations: {
                        self.playerImageView.alpha = 0
                        self.botImageView.alpha = 0
                    })
                    self.rockButton.isEnabled = true
                    self.paperButton.isEnabled = true
                    self.scissorsButton.isEnabled = true
                })
            })
        })
    }
    
    func to3CheckWhoWon() {
        if playerPoints >= 3 {
            to3FadeOut()
        } else if botPoints >= 3 {
            to3FadeOut()
        }
    }
    
    func to3FadeOut() {
        UIView.animate(withDuration: 0.3, animations: {
            self.backButtonView.center.y = self.backButtonView.center.y + 150
            self.playerPointsLabel.alpha = 0
            self.botPointsLabel.alpha = 0
        }, completion: { (_) in
            self.performSegue(withIdentifier: "goToSummary", sender: nil)
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToSummary" {
            let summaryVC = segue.destination as! SummaryViewController
            summaryVC.playerPoints = self.playerPoints
            summaryVC.botPoints = self.botPoints
        }
    }
    
}

