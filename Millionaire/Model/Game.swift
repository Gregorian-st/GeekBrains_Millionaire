//
//  Game.swift
//  Millionaire
//
//  Created by Grigory Stolyarov on 21.02.2021.
//

import Foundation

final class Game {
    
    static let instance = Game()
    private let recordsCaretaker = RecordsCaretaker()
    
    var session: GameSession
    private (set) var records: [Record] {
        didSet {
            recordsCaretaker.saveRecords(records: records)
        }
    }
    
    private init() {
        records = recordsCaretaker.loadRecords()
        session = GameSession()
    }
    
    func addRecord(_ record: Record) {
        if record.earned > 0 {
            var tempRecords = self.records
            tempRecords.append(record)
            tempRecords.sort {
                $0.earned > $1.earned
            }
            self.records = tempRecords
        }
    }
    
    func clearRecords() {
        self.records = []
        recordsCaretaker.clearRecords()
    }
    
}
