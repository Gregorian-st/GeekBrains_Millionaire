//
//  Question.swift
//  Millionaire
//
//  Created by Grigory on 19.02.2021.
//

import Foundation

struct Question {
    
    enum Answer: Int {
        case a, b, c, d
    }
    
    var questionText: String
    var answerSet: [String]
    var rightAnswer: Answer
    
}
