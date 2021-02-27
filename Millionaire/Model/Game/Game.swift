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
    private let shuffleMethodCaretaker = ShuffleMethodCaretaker()
    
    var session: GameSession!
    var strategy: CreateQuestionsStrategy!
    private (set) var records: [Record] {
        didSet {
            recordsCaretaker.saveRecords(records: records)
        }
    }
    var shuffleMethod: ShuffleMethod {
        didSet {
            shuffleMethodCaretaker.saveShuffleMethod(shuffleMethod: shuffleMethod)
            strategy = getStrategy(shuffleMethod: shuffleMethod)
        }
    }
    
    private init() {
        records = recordsCaretaker.loadRecords()
        shuffleMethod = shuffleMethodCaretaker.loadShuffleMethod()
        strategy = getStrategy(shuffleMethod: shuffleMethod)
        session = GameSession(createQuestionsStrategy: strategy)
    }
    
    func getStrategy(shuffleMethod: ShuffleMethod) -> CreateQuestionsStrategy {
        switch shuffleMethod {
        case .randomByCategory:
            return ShuffleStrategyByCategory()
        case .randomAll:
            return ShuffleStrategyAll()
        }
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
    }
    
}
