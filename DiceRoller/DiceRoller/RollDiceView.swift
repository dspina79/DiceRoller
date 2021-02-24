//
//  RollDiceView.swift
//  DiceRoller
//
//  Created by Dave Spina on 2/20/21.
//

import SwiftUI

protocol Dice {
    var minValue: Int {get set}
    var maxValue: Int {get set}
    var diceValue: Int {get set}
}

struct FourSidedDice: View, Dice {
    var minValue = 1
    var maxValue = 4
    
    @Binding var diceValue: Int
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.blue)
                .frame(width: 100, height: 100)
            Text("\(self.diceValue)")
                .font(.largeTitle)
                .foregroundColor(.white)
        }
    }
}


struct TwelveSidedDice: View, Dice {
    var minValue = 1
    var maxValue = 12
    
    @Binding var diceValue: Int
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(.blue)
                .frame(width: 100, height: 100)
            Text("\(self.diceValue)")
                .font(.largeTitle)
                .foregroundColor(.white)
        }
    }
}

struct TwentySidedDice: View, Dice {
    var minValue = 1
    var maxValue = 20
    
    @Binding var diceValue: Int
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(.blue)
                .frame(width: 100, height: 100)
            Text("\(self.diceValue)")
                .font(.largeTitle)
                .foregroundColor(.white)
        }
    }
}


struct HundredSidedDice: View, Dice {
    var minValue = 1
    var maxValue = 100
    
    @Binding var diceValue: Int
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(.blue)
                .frame(width: 100, height: 100)
            Text("\(self.diceValue)")
                .font(.largeTitle)
                .foregroundColor(.white)
        }
    }
}

struct SixSidedDice: View, Dice {
    var minValue = 1
    var maxValue = 6
    
    @Binding var diceValue: Int
    var body: some View {
        Image(systemName: "die.face.\(self.diceValue).fill")
            .resizable()
            .scaledToFill()
            .foregroundColor(.blue)
            .frame(width: 100, height: 100)
    }
}

struct RollDiceView: View {
    let timer = Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()
    
    @State private var firstDiceValue: Int = 1
    @State private var secondDiceValue: Int = 2
    @State private var diceType: String = "6-sided"
    
    static var rollCounter = 11 // off
    
    private var currentRoll: Int {
        return firstDiceValue + secondDiceValue
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                HStack {
                    if diceType == "4-sided" {
                        FourSidedDice(diceValue: $firstDiceValue)
                        FourSidedDice(diceValue: $secondDiceValue)
                    } else if diceType == "6-sided" {
                        SixSidedDice(diceValue: $firstDiceValue)
                        SixSidedDice(diceValue: $secondDiceValue)
                    } else if diceType == "12-sided" {
                        TwelveSidedDice(diceValue: $firstDiceValue)
                        TwelveSidedDice(diceValue: $secondDiceValue)
                    } else if diceType == "20-sided" {
                        TwentySidedDice(diceValue: $firstDiceValue)
                        TwentySidedDice(diceValue: $secondDiceValue)
                    } else {
                        HundredSidedDice(diceValue: $firstDiceValue)
                        HundredSidedDice(diceValue: $secondDiceValue)
                    }
                }
                Text("Roll \(currentRoll)")
                    .font(.largeTitle)
                
                Button("Roll") {
                    Self.rollCounter = 0
                }
                    .padding()
                    .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .background(Color.gray)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
            }
        }
        .onAppear(perform: loadSettingData)
        .onReceive(self.timer, perform: { time in
            if Self.rollCounter == 10 {
                roll(diceTypeName: self.diceType, saveData: true)
                Self.rollCounter += 1
            } else if Self.rollCounter < 10 {
                roll(diceTypeName: diceType, saveData: false)
                Self.rollCounter += 1
            } else {
                // pass
            }
        })
    }
    
    func loadSettingData() {
        self.diceType = SettingsView.getSettings().diceType
    }
    
    func getDiceView(diceType: String) -> Dice {
        let val: Int = 0
        if diceType == "4-sided" {
            return FourSidedDice(diceValue: .constant(val))
        } else if diceType == "6-sided" {
            return SixSidedDice(diceValue: .constant(val))
        } else if diceType == "12-sided" {
            return TwelveSidedDice(diceValue: .constant(val))
        } else if diceType == "20-sided" {
            return TwentySidedDice(diceValue: .constant(val))
        }
        return HundredSidedDice(diceValue: .constant(val))
        
    }
    
    func roll(diceTypeName: String, saveData: Bool) {
        let diceType = getDiceView(diceType: diceTypeName)
        let possibleValues: [Int] = Array(diceType.minValue...diceType.maxValue)
        self.firstDiceValue = possibleValues.randomElement() ?? 1
        self.secondDiceValue = possibleValues.randomElement() ?? 1
        
        if saveData {
            // save the data
            let diceResults = DiceResults()
            diceResults.addResult(diceType: diceTypeName, totalRollAmount: currentRoll)
            diceResults.saveData()
        }
    }
}

struct RollDiceView_Previews: PreviewProvider {
    static var previews: some View {
        RollDiceView()
    }
}
