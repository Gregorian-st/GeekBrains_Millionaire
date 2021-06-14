//
//  SettingsViewController.swift
//  Millionaire
//
//  Created by Grigory Stolyarov on 26.02.2021.
//

import UIKit

class SettingsViewController: UIViewController {
    
    let game = Game.instance
    
    @IBOutlet weak var shuffleMethodControl: UISegmentedControl!
    
    @IBAction func shuffleMethodControlDidChange(_ sender: UISegmentedControl) {
        game.shuffleMethod = ShuffleMethod(rawValue: sender.selectedSegmentIndex) ?? .randomByCategory
    }
    
    override func viewDidLoad() {
        shuffleMethodControl.selectedSegmentIndex = game.shuffleMethod.rawValue
    }
    
}
