//
//  Question.swift
//  Millionaire
//
//  Created by Grigory on 19.02.2021.
//

import Foundation

final class Question {
    
    enum Answer: Int {
        case a, b, c, d
    }
    
    var questionText: String = ""
    var answerSet: [String] = ["", "", "", ""]
    var rightAnswer: Answer = .a
    
    enum CodingKeys: String, CodingKey {
        case questionText
        case answerSet
        case rightAnswer
    }
    
    convenience init(questionText: String, answerSet: [String], rightAnswer: Answer) {
        self.init()
        self.questionText = questionText
        self.answerSet = answerSet
        self.rightAnswer = rightAnswer
    }
    
}

extension Question: Equatable {
    
    static func == (lhs: Question, rhs: Question) -> Bool {
        return lhs.questionText == rhs.questionText
    }
    
}

extension Question: Encodable {
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.questionText, forKey: .questionText)
        try container.encode(self.answerSet, forKey: .answerSet)
        try container.encode(self.rightAnswer.rawValue, forKey: .rightAnswer)
    }
    
}

extension Question: Decodable {
    
    convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.questionText = try container.decodeIfPresent(String.self, forKey: .questionText) ?? ""
        self.answerSet = try container.decodeIfPresent([String].self, forKey: .answerSet) ?? ["", "", "", ""]
        self.rightAnswer = try Answer(rawValue: container.decodeIfPresent(Int.self, forKey: .rightAnswer) ?? 0) ?? .a
    }
    
}
