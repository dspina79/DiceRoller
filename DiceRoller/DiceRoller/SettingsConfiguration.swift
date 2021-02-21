//
//  SettingsConfiguration.swift
//  DiceRoller
//
//  Created by Dave Spina on 2/20/21.
//

import Foundation

class SettingsConfiguration: Codable, ObservableObject {
    static let DICE_TYPES: [String] = ["4-sided, 6-sided, 12-sided, 20-sided, 100-sided"]
    var currentDiceType: String = "6-sided"
}
