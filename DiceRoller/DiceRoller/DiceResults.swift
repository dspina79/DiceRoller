//
//  DiceResults.swift
//  DiceRoller
//
//  Created by Dave Spina on 2/20/21.
//

import Foundation

struct DiceResult: Codable {
    var id = UUID()
    var diceType: String = ""
    var numberOfDice: Int = 0
    var totalRoll: Int = 0
}



class DiceResults: ObservableObject, Codable {
    var results = [DiceResult]()
    
    func getTotals() -> Dictionary<Int, Int> {
        var totals = Dictionary<Int, Int>()
        
        for result in self.results {
            totals[result.totalRoll] = (totals[result.totalRoll] ?? 0) + 1
        }
        
        return totals
    }
}
