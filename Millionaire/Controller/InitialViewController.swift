//
//  InitialViewController.swift
//  Millionaire
//
//  Created by Grigory on 18.02.2021.
//

import UIKit

class InitialViewController: UIViewController {
    
    var gameSession: GameSession = GameSession()
    let game = Game.instance
    
    @IBAction func unwindFromGame(_ segue: UIStoryboardSegue) {}

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let gameViewController = segue.destination as? GameViewController
        else { return }
        initGame()
        gameViewController.gameDelegate = self
    }
    
    func initGame() {
        gameSession = GameSession()
        game.session = gameSession
    }

}

extension InitialViewController: GameViewDelegate {

    func gameFinished(with earned: Int) {
        game.addRecord(Record(date: Date(), earned: earned))
    }
    
    func nextQuestion() -> Bool {
        return gameSession.nextQuestion()
    }

}
