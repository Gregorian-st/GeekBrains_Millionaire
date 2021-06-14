//
//  CreateQuestionsStrategy.swift
//  Millionaire
//
//  Created by Grigory Stolyarov on 26.02.2021.
//

import Foundation

protocol CreateQuestionsStrategy {
    func createQuestions() -> [Question]
}

class ShuffleStrategyByCategory: CreateQuestionsStrategy {
    
    func createQuestions() -> [Question] {
        var gameQuestions: [Question] = []
        let questionStorage = QuestionStorage()
        for i in (0...14) {
            gameQuestions.append(questionStorage.questionPoolByCategory.randomElement()![i])
        }
        return gameQuestions
    }
    
}

// User Questions are only used in ShuffleStrategyAll
class ShuffleStrategyAll: CreateQuestionsStrategy {
    
    func createQuestions() -> [Question] {
        var gameQuestions: [Question] = []
        let questionStorage = QuestionStorage()
        var questions = questionStorage.questionPoolByCategory.flatMap { $0 }
        questions.append(contentsOf: questionStorage.userQuestionPool)
        while gameQuestions.count < 15 {
            let question = questions.randomElement()!
            if !gameQuestions.contains(question) {
                gameQuestions.append(question)
            }
        }
        return gameQuestions
    }
    
}
