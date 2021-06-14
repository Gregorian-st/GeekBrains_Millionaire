//
//  GameViewController.swift
//  Millionaire
//
//  Created by Grigory Stolyarov on 21.02.2021.
//

import UIKit

protocol GameViewDelegate: AnyObject {
    func gameFinished(with earned: Int)
}

class GameViewController: UIViewController {
    
    var gameQuestions: [Question] = []
    let game = Game.instance
    let nc = NotificationCenter.default
    weak var gameDelegate: GameViewDelegate!
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var lastSumLabel: UILabel!
    @IBOutlet weak var finishButton: UIButton!
    @IBOutlet var answerButtons: [UIButton]!
    @IBOutlet var answerLabels: [UILabel]!
    @IBOutlet weak var questionTextView: UITextView!
    
    @IBAction func buttonFinishDidTapped(_ sender: UIButton) {
        let earned = game.session.earnToTake
        gameDelegate.gameFinished(with: earned)
        showMessageAndExit(message: "Поздравляем!\nВы заработали \(earned)₽")
    }
    
    @IBAction func buttonAnswerDidTapped(_ sender: UIButton) {
        checkAnswer(tag: sender.tag)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nc.addObserver(self, selector: #selector(updateView), name: Notification.Name("UpdateView"), object: nil)
        gameQuestions = game.session.strategy.createQuestions()
        updateView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        nc.removeObserver(self)
    }
    
    @objc func updateView() {
        let qNum = game.session.currentQuestion - 1
        questionLabel.text = "Вопрос №\(game.session.currentQuestion)"
        lastSumLabel.text = "Можно забрать \(game.session.earnToTake)₽"
        questionTextView.text = gameQuestions[qNum].questionText
        answerLabels.forEach {
            $0.isHidden = false
        }
        answerButtons.forEach {
            $0.isHidden = false
            $0.setTitle(gameQuestions[qNum].answerSet[$0.tag] , for: .normal)
        }
        finishButton.isHidden = qNum == 0
    }
    
    func checkAnswer(tag: Int) {
        let qNum = game.session.currentQuestion - 1
        if gameQuestions[qNum].rightAnswer.rawValue == tag {
            if !game.session.nextQuestion() {
                let earned = game.session.earnedMin
                gameDelegate.gameFinished(with: earned)
                showMessageAndExit(message: "Поздравляем! Вы выиграли!\nВы заработали \(earned)₽")
            }
        } else {
            let earned = game.session.earnedMin
            gameDelegate.gameFinished(with: earned)
            showMessageAndExit(message: "Ответ неверный!\nВы заработали \(earned)₽")
        }
    }
    
    func showMessageAndExit(message: String) {
        let alertController = UIAlertController(title: "Кто хочет стать миллионером",
                                                message: message,
                                                preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { [weak self] _ in
            self?.performSegue(withIdentifier: "unwindFromGame", sender: self)
        } ))
        present(alertController, animated: true, completion: nil)
    }
    
}
