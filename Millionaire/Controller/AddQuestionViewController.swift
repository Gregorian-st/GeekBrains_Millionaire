//
//  AddQuestionViewController.swift
//  Millionaire
//
//  Created by Grigory Stolyarov on 26.02.2021.
//

import UIKit

class AddQuestionViewController: UIViewController {
    
    private let questionsStorage = QuestionStorage()
    var question = Question()
    
    @IBOutlet weak var questionTextView: UITextView!
    @IBOutlet var answerCollection: [UITextField]!
    @IBOutlet weak var rightAnswerControl: UISegmentedControl!
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "unwindFromAddQuestion", sender: self)
    }
    
    @IBAction func addQuestionButtonTapped(_ sender: UIButton) {
        addQuestion()
    }
    
    func addQuestion() {
        if validateQuestion() {
            if !questionsStorage.userQuestionPool.contains(question) {
                questionsStorage.userQuestionPool.append(question)
                showMessage(message: "Вопрос добавлен", exit: true)
            } else {
                showMessage(message: "Такой вопрос уже есть!", exit: false)
            }
        } else {
            showMessage(message: "Все поля должны быть заполнены!", exit: false)
        }
    }
    
    func validateQuestion() -> Bool {
        question.questionText = questionTextView.text.trimmingCharacters(in: [" "])
        question.answerSet.removeAll()
        for i in (0...3) {
            question.answerSet.append(answerCollection.first(where: {$0.tag == i})?.text?.trimmingCharacters(in: [" "]) ?? "")
        }
        question.rightAnswer = Question.Answer(rawValue: rightAnswerControl.selectedSegmentIndex) ?? .a
        
        return (question.questionText != "") && ( question.answerSet[0] != "") && ( question.answerSet[1] != "") && ( question.answerSet[2] != "") && ( question.answerSet[3] != "")
    }
    
    func showMessage(message: String, exit: Bool) {
        let alertController = UIAlertController(title: "Кто хочет стать миллионером",
                                                message: message,
                                                preferredStyle: UIAlertController.Style.alert)
        if exit {
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) { [weak self] _ in
                self?.performSegue(withIdentifier: "unwindFromAddQuestion", sender: self) } )
        } else {
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        }
        present(alertController, animated: true, completion: nil)
    }
    
}
