//
//  PauseViewController.swift
//  RPS
//
//  Created by Marcin Bartminski on 13/01/2020.
//  Copyright © 2020 Marcin Bartminski. All rights reserved.
//

import UIKit

class PauseViewController: UIViewController {
    
    @IBOutlet weak var backToMenuButton: UIButton!
    @IBOutlet weak var resumeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backToMenuButton.layer.cornerRadius = backToMenuButton.frame.size.height/2
        resumeButton.layer.cornerRadius = resumeButton.frame.size.height/2
    }
    
    @IBAction func backToMenuButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "backToMenu", sender: nil)
    }
    @IBAction func resumeButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
