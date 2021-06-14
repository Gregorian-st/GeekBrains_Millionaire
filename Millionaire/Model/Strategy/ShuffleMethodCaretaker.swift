//
//  ShuffleMethodCaretaker.swift
//  Millionaire
//
//  Created by Grigory Stolyarov on 26.02.2021.
//

import Foundation

class ShuffleMethodCaretaker {
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    private let key = "MillionaireShuffleMethod"
    
    func saveShuffleMethod(shuffleMethod: ShuffleMethod) {
        UserDefaults.standard.setValue(shuffleMethod.rawValue, forKey: key)
    }
    
    func loadShuffleMethod() -> ShuffleMethod {
        let value = UserDefaults.standard.integer(forKey: key)
        return ShuffleMethod(rawValue: value) ?? .randomByCategory
    }
    
}
