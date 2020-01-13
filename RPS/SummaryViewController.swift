//
//  SummaryViewController.swift
//  RPS
//
//  Created by Marcin Bartminski on 12/01/2020.
//  Copyright © 2020 Marcin Bartminski. All rights reserved.
//

import UIKit

class SummaryViewController: UIViewController {
    
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var whoWinsLabel: UILabel!
    @IBOutlet weak var backToMenuButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    
    var playerPoints = 0
    var botPoints = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pointsLabel.text = "\(playerPoints) - \(botPoints)"
        if playerPoints > botPoints {
            self.whoWinsLabel.text = "You Win!"
        } else {
            self.whoWinsLabel.text = "You Lose!"
        }
        
        backToMenuButton.layer.cornerRadius = backToMenuButton.frame.size.height/2
        shareButton.layer.cornerRadius = shareButton.frame.size.height/2
        
        pointsLabel.alpha = 0
        whoWinsLabel.alpha = 0
        backToMenuButton.alpha = 0
        shareButton.alpha = 0
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.3, animations: {
            self.pointsLabel.alpha = 1
        }, completion: { (_) in
            UIView.animate(withDuration: 0.3, animations: {
                self.whoWinsLabel.alpha = 1
            }, completion: { (_) in
                UIView.animate(withDuration: 0.3, animations: {
                    self.backToMenuButton.alpha = 1
                    self.shareButton.alpha = 1
                })
            })
        })
    }
    
    @IBAction func backToMenuButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "goToModesFromSummary", sender: nil)
    }
    
    @IBAction func shareButtonPressed(_ sender: Any) {
        
        let text = "I just got \(pointsLabel.text!) in RPS: Ultimate. You should really check it out!"
        
        // set up activity view controller
        let textToShare = [ text ]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash

        // exclude some activity types from the list (optional)
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]

        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
        
    }
    
}
