//
//  QuestionStorageCaretaker.swift
//  Millionaire
//
//  Created by Grigory Stolyarov on 26.02.2021.
//

import Foundation

class QuestionStorageCaretaker {
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    private let key = "MillionaireQuestions"
    
    func saveQuestions(questions: [Question]) {
        do {
            let data: Data = try encoder.encode(questions)
            UserDefaults.standard.setValue(data, forKey: key)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func loadQuestions() -> [Question] {
        guard let data: Data = UserDefaults.standard.data(forKey: key) else {
            return []
        }
        
        do {
            return try decoder.decode([Question].self, from: data)
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
}
