//
//  RecordCaretaker.swift
//  Millionaire
//
//  Created by Grigory Stolyarov on 21.02.2021.
//

import Foundation

class RecordsCaretaker {
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    private let key = "MillionaireRecords"
    
    func saveRecords(records: [Record]) {
        do {
            let data: Data = try encoder.encode(records)
            UserDefaults.standard.setValue(data, forKey: key)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func loadRecords() -> [Record] {
        guard let data: Data = UserDefaults.standard.data(forKey: key) else {
            return []
        }
        
        do {
            return try decoder.decode([Record].self, from: data)
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    func clearRecords() {
        UserDefaults.standard.setValue(nil, forKey: key)
    }
    
}
