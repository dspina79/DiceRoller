//
//  SettingsView.swift
//  DiceRoller
//
//  Created by Dave Spina on 2/20/21.
//

import SwiftUI

struct DiceRollSettings: Codable {
    static let DiceTypes: [String] = ["4-sided", "6-sided", "12-sided", "20-sided", "100-sided"]
    static let DiceSettingsKey = "DiceRollSettings"
    var diceType: String = "6-sided"
}

struct SettingsView: View {
    @State private var diceSettings: DiceRollSettings = DiceRollSettings()
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Dice Configuration")) {
                    Picker(selection: $diceSettings.diceType, label: Text("Dice Type")) {
                        ForEach(DiceRollSettings.DiceTypes, id:\.self) {diceType in
                            Text("\(diceType)")
                        }
                    }
                }
            }.navigationBarTitle(Text("Settings"))
            
        }.onAppear {
            self.diceSettings = getSettings()
        }
    }
    
    func getSettings() -> DiceRollSettings {
        if let data = UserDefaults.standard.data(forKey: DiceRollSettings.DiceSettingsKey) {
            if let decoded = try? JSONDecoder().decode(DiceRollSettings.self, from: data) {
                return decoded
            }
        }
        
        return DiceRollSettings()
    }
    
    func saveSettings() {
        if let encoded = try? JSONEncoder().encode(self.diceSettings) {
            UserDefaults.standard.setValue(encoded, forKey: DiceRollSettings.DiceSettingsKey)
        } else {
            print("Error generating saved settings data:")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
