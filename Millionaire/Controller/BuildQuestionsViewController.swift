//
//  BuildQuestionsViewController.swift
//  Millionaire
//
//  Created by Grigory Stolyarov on 26.02.2021.
//

import UIKit

class BuildQuestionsViewController: UIViewController {
    
    private let questionBuilder = QuestionBuilder()
    private let questionsStorage = QuestionStorage()
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "unwindFromBuildQuestions", sender: self)
    }
    
    @IBAction func addQuestionButtonTapped(_ sender: UIButton) {
        questionBuilder.addQuestion(question: Question())
        tableView.reloadData()
    }
        
    @IBAction func rightAnswerValueChanged(_ sender: UISegmentedControl) {
        guard let indexPath = tableView.indexPath(for: sender.forFirstBaselineLayout)
        else { return }
        questionBuilder.questions[indexPath.row].rightAnswer = Question.Answer(rawValue: sender.selectedSegmentIndex) ?? .a
    }
    
    @IBAction func addQuestionsButtonTapped(_ sender: UIButton) {
        questionsStorage.userQuestionPool.append(contentsOf: questionBuilder.build())
        performSegue(withIdentifier: "unwindFromBuildQuestions", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionBuilder.userQuestions = questionsStorage.userQuestionPool
    }
        
}

extension BuildQuestionsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 340
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionBuilder.questionsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: QuestionTableViewCell.reuseIdentifier, for: indexPath) as! QuestionTableViewCell

        cell.questionDelegate = self
        
        let question = questionBuilder.questions[indexPath.row]
        cell.questionText.text = question.questionText
        for i in (0...3) {
            cell.answerCollection.first(where: { $0.tag == i})?.text = question.answerSet[i]
        }
        cell.rightAnswerControl.selectedSegmentIndex = question.rightAnswer.rawValue
        
        return cell
    }
    
}

extension BuildQuestionsViewController: QuestionDelegate {

    func textFieldChanged(textField: UITextField) {
        guard let indexPath = tableView.indexPath(for: textField.textInputView)
        else { return }
        
        switch textField.tag {
        case -1:
            questionBuilder.questions[indexPath.row].questionText = textField.text ?? ""
        case 0...3:
            questionBuilder.questions[indexPath.row].answerSet[textField.tag] = textField.text ?? ""
        default:
            return
        }
    }

}

