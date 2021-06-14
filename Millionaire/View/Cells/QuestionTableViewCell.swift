//
//  QuestionTableViewCell.swift
//  Millionaire
//
//  Created by Grigory Stolyarov on 26.02.2021.
//

import UIKit

protocol QuestionDelegate: AnyObject {
    func textFieldChanged(textField: UITextField)
}

class QuestionTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "QuestionCell"
    weak var questionDelegate: QuestionDelegate!
    
    @IBOutlet weak var questionText: UITextField! {
        didSet {
            questionText.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        }
    }
    @IBOutlet var answerCollection: [UITextField]! {
        didSet {
            answerCollection.forEach { $0.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged) }
        }
    }
    @IBOutlet weak var rightAnswerControl: UISegmentedControl!
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        questionDelegate.textFieldChanged(textField: textField)
    }
    
}
