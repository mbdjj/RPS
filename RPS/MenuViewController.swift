//
//  MenuViewController.swift
//  RPS
//
//  Created by Marcin Bartminski on 08/01/2020.
//  Copyright © 2020 Marcin Bartminski. All rights reserved.
//

import UIKit
import GameKit

class MenuViewController: UIViewController {
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var orangeView: UIView!
    
    var viewResized = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playButton.layer.cornerRadius = playButton.frame.width/2
        playButton.alpha = 1
        
        orangeView.frame.size = playButton.frame.size
        orangeView.layer.cornerRadius = orangeView.frame.width/2
        orangeView.center = playButton.center
        orangeView.alpha = 0
        
        self.view.bringSubviewToFront(orangeView)
        self.view.bringSubviewToFront(playButton)
        
        authenticateUser()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !viewResized {
            orangeView.center = playButton.center
        } else {
            UIView.animate(withDuration: 0.5, animations: {
                self.playButton.alpha = 1
                self.orangeView.transform = .identity
                self.orangeView.center = self.playButton.center
            }, completion: { (_) in
                self.viewResized = false
                self.orangeView.alpha = 0
            })
        }
    }
    
    @IBAction func playButtonPressed(_ sender: Any) {
        orangeView.alpha = 1
        orangeView.center = playButton.center
        
        UIView.animate(withDuration: 0.5, animations: {
            self.orangeView.center = self.view.center
            self.orangeView.transform = CGAffineTransform(scaleX: 18, y: 18)
            self.playButton.alpha = 0
        }, completion: { (_) in
            self.viewResized = true
            self.performSegue(withIdentifier: "goChooseMode", sender: nil)
        })
    }
    
    func authenticateUser() {
        let player = GKLocalPlayer.local
        player.authenticateHandler = { vc, error in
            
            guard error == nil else {
                print(error?.localizedDescription ?? "błąd")
                return
            }
            
            if let vc = vc {
                self.present(vc, animated: true, completion:  nil)
            }
        }
    }
    
}
