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
        
        pointsLabel.alpha = 0
        whoWinsLabel.alpha = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.3, animations: {
            self.pointsLabel.alpha = 1
        }, completion: { (_) in
            UIView.animate(withDuration: 0.3, animations: {
                self.whoWinsLabel.alpha = 1
            })
        })
    }
    
}
