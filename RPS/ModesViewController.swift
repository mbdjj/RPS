//
//  ModesViewController.swift
//  RPS
//
//  Created by Marcin Bartminski on 08/01/2020.
//  Copyright © 2020 Marcin Bartminski. All rights reserved.
//

import UIKit

class ModesViewController: UIViewController {
    
    @IBOutlet weak var endlessButton: UIButton!
    @IBOutlet weak var to3Button: UIButton!
    @IBOutlet weak var transitionView: UIView!
    @IBOutlet weak var gameModesLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    var mode = ""
    var modeChosen = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        endlessButton.layer.cornerRadius = endlessButton.frame.size.height/2
        endlessButton.layer.borderWidth = 5
        endlessButton.layer.borderColor = UIColor.black.cgColor
        endlessButton.alpha = 0
        
        to3Button.layer.cornerRadius = to3Button.frame.size.height/2
        to3Button.layer.borderWidth = 5
        to3Button.layer.borderColor = UIColor.black.cgColor
        to3Button.alpha = 0
        
        transitionView.frame.size = CGSize(width: endlessButton.frame.size.height, height: endlessButton.frame.size.height)
        transitionView.layer.cornerRadius = transitionView.frame.size.width/2
        transitionView.center = endlessButton.center
        transitionView.alpha = 0
        
        gameModesLabel.alpha = 0
        
        backButton.alpha = 0
        
        endlessButton.transform = CGAffineTransform(scaleX: 0, y: 0)
        to3Button.transform = CGAffineTransform(scaleX: 0, y: 0)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !modeChosen {
            endlessButton.alpha = 1
            to3Button.alpha = 1
            
            self.view.bringSubviewToFront(endlessButton)
            
            UIView.animate(withDuration: 0.3) {
                self.gameModesLabel.alpha = 1
                self.backButton.alpha = 1
                self.endlessButton.transform = .identity
                self.to3Button.transform = .identity
            }
        } else {
            UIView.animate(withDuration: 0.5, animations: {
                self.transitionView.transform = .identity
                if self.mode == "endless" {
                    self.transitionView.center = self.endlessButton.center
                } else if self.mode == "to3" {
                    self.transitionView.center = self.to3Button.center
                }
                self.to3Button.alpha = 1
                self.endlessButton.alpha = 1
                self.gameModesLabel.alpha = 1
                self.backButton.alpha = 1
            }, completion: { (_) in
                self.transitionView.alpha = 0
            })
        }
    }
    
    //MARK: - backButton
    
    @IBAction func backButtonPressed(_ sender: Any) {
        UIView.animate(withDuration: 0.3, animations: {
            self.gameModesLabel.alpha = 0
            self.backButton.alpha = 0
            self.endlessButton.alpha = 0
            self.to3Button.alpha = 0
        }, completion: { (_) in
            self.dismiss(animated: false, completion: nil)
        })
    }
    
    //MARK: - endlessButton
    
    @IBAction func endlessButtonPressedDown(_ sender: Any) {
        print("endless button pressed down")
        UIView.animate(withDuration: 0.2) {
            self.endlessButton.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }
    }
    @IBAction func endlessButtonPressed(_ sender: Any) {
        transitionView.center = self.endlessButton.center
        mode = "endless"
        fadeOutAnimation()
    }
    
    //MARK: - to3Button
    
    @IBAction func to3ButtonPressedDown(_ sender: Any) {
        print("to 3 button pressed down")
        UIView.animate(withDuration: 0.2) {
            self.to3Button.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }
    }
    @IBAction func to3ButtonPressed(_ sender: Any) {
        transitionView.center = self.to3Button.center
        mode = "to3"
        fadeOutAnimation()
    }
    
    //MARK: - functions
    
    func fadeOutAnimation() {
        print(mode)
        self.transitionView.alpha = 1
        UIView.animate(withDuration: 0.2, animations: {
            self.endlessButton.transform = .identity
            self.to3Button.transform = .identity
        }, completion: { (_) in
            UIView.animate(withDuration: 0.5, animations: {
                self.to3Button.alpha = 0
                self.endlessButton.alpha = 0
                self.gameModesLabel.alpha = 0
                self.backButton.alpha = 0
                self.transitionView.center = self.view.center
                self.transitionView.transform = CGAffineTransform(scaleX: 28, y: 28)
            }, completion: { (_) in
                self.modeChosen = true
                self.performSegue(withIdentifier: "goToGame", sender: nil)
            })
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("prepare called")
        if segue.identifier == "goToGame" {
            let gameVC = segue.destination as! GameViewController
            gameVC.mode = self.mode
        }
    }
    
    @IBAction func unwindToModesViewController(segue: UIStoryboardSegue) {
        //nothing goes here
    }
    
}
