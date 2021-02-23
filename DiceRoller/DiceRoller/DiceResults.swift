//
//  DiceResults.swift
//  DiceRoller
//
//  Created by Dave Spina on 2/20/21.
//

import Foundation

struct DiceResultRollCounter: Codable {
    var id = UUID()
    var diceType: String
    var instanceCount: Int = 1
}

struct DiceResultValue: Codable, Comparable {
    static func == (lhs: DiceResultValue, rhs: DiceResultValue) -> Bool {
        return lhs.total == rhs.total
    }
    
    static func < (lhs: DiceResultValue, rhs: DiceResultValue) -> Bool {
        return lhs.total < rhs.total
    }
    
    var id = UUID()
    var total: Int
    var counters = [DiceResultRollCounter]()
}


class DiceResults: ObservableObject, Codable {
    static let DataKey = "RollResultsData"
    var results = [DiceResultValue]()
    
    
    static var example: DiceResults {
        let resultData = DiceResults()
        resultData.addResult(diceType: "6-sided", totalRollAmount: 2)
        resultData.addResult(diceType: "6-sided", totalRollAmount: 4)
        resultData.addResult(diceType: "6-sided", totalRollAmount: 6)
        resultData.addResult(diceType: "6-sided", totalRollAmount: 7)
        resultData.addResult(diceType: "6-sided", totalRollAmount: 7)
        resultData.addResult(diceType: "6-sided", totalRollAmount: 8)
        
        resultData.addResult(diceType: "12-sided", totalRollAmount: 7)
        resultData.addResult(diceType: "12-sided", totalRollAmount: 8)
        resultData.addResult(diceType: "12-sided", totalRollAmount: 17)
        resultData.addResult(diceType: "12-sided", totalRollAmount: 18)
        
        resultData.addResult(diceType: "100-sided", totalRollAmount: 7)
        resultData.addResult(diceType: "100-sided", totalRollAmount: 18)
        resultData.addResult(diceType: "100-sided", totalRollAmount: 50)
        resultData.addResult(diceType: "100-sided", totalRollAmount: 99)
        
        return resultData
    }
    
    func load() {
        self.results = Self.getData()
    }
    
    static func getData() -> [DiceResultValue] {
        if let data = UserDefaults.standard.data(forKey: Self.DataKey) {
            if let decoded = try? JSONDecoder().decode([DiceResultValue].self, from: data) {
                return decoded
            }
        }
        return [DiceResultValue]()
    }
    
    func saveData() {
        if let jsonData = try? JSONEncoder().encode(self.results) {
            UserDefaults.standard.setValue(jsonData, forKey: Self.DataKey)
        } else {
            print("There was an error saving roll data.")
        }
    }
    
    func addResult(diceType: String, totalRollAmount: Int) {
        if let diceResultIndex = results.firstIndex(where: {$0.total == totalRollAmount}) {
            if let diceCounterIndex = results[diceResultIndex].counters.firstIndex(where: {$0.diceType == diceType}) {
                results[diceResultIndex].counters[diceCounterIndex].instanceCount += 1
            } else {
                results[diceResultIndex].counters.append(DiceResultRollCounter(diceType: diceType))
            }
        } else {
            var diceResult = DiceResultValue(total: totalRollAmount)
            diceResult.counters.append(DiceResultRollCounter(diceType: diceType))
            results.append(diceResult)
        }
    }
}
