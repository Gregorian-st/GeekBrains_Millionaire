//
//  QuestionBuilder.swift
//  Millionaire
//
//  Created by Grigory Stolyarov on 26.02.2021.
//

import Foundation

class QuestionBuilder {
    
    var userQuestions: [Question] = []
    var questions: [Question] = [Question()]
    var questionsCount: Int {
        get {
            return questions.count
        }
    }
    
    func addQuestion(question: Question) {
        questions.append(question)
    }
    
    // Returns only properly filled unique questions
    func build() -> [Question] {
        if questionsCount == 0 {
            return []
        }
        
        var questionsChecked: [Question] = []
        for i in (0..<questionsCount) {
            if validateQuestion(question: questions[i]) && !userQuestions.contains(questions[i]) {
                questionsChecked.append(questions[i])
            }
        }

        return questionsChecked
    }
    
    func validateQuestion(question: Question) -> Bool {
        return (question.questionText != "") && ( question.answerSet[0] != "") && ( question.answerSet[1] != "") && ( question.answerSet[2] != "") && ( question.answerSet[3] != "")
    }
    
}
