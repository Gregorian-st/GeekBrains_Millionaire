//
//  GameSession.swift
//  Millionaire
//
//  Created by Grigory Stolyarov on 21.02.2021.
//

import Foundation

class GameSession {
    
    private let questionMaxNum = 15
    private let costArray: [Int] = [0, 500, 1000, 2000, 3000, 5000, 10000, 15000, 25000, 50000, 100000, 200000, 400000, 800000, 1500000, 3000000]
    
    var currentQuestion: Int = 1
    var lastQuestion: Int {
        get {
            return currentQuestion - 1
        }
    }
    var earnToTake: Int {
        get {
            return costArray[lastQuestion]
        }
    }
    var earnedMin: Int {
        get {
            switch lastQuestion {
            case 5...9: return costArray[5]
            case 10...14: return costArray[10]
            case 15...: return costArray[15]
            default:
                return 0
            }
        }
    }
    var strategy: CreateQuestionsStrategy
//    var hintVoteAvail: Bool = true
//    var hint50Avail: Bool = true
//    var hintCallAvail: Bool = true
    
    init(createQuestionsStrategy: CreateQuestionsStrategy) {
        self.strategy = createQuestionsStrategy
    }
    
    func nextQuestion() -> Bool {
        currentQuestion += 1
        let gameContinue = currentQuestion <= questionMaxNum
        if gameContinue {
            NotificationCenter.default.post(name: Notification.Name("UpdateView"), object: nil)
        }
        return gameContinue
    }

}
