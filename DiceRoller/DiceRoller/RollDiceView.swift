//
//  RollDiceView.swift
//  DiceRoller
//
//  Created by Dave Spina on 2/20/21.
//

import SwiftUI

struct BigDice: View {
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
    @State private var firstDiceValue: Int = 1
    @State private var secondDiceValue: Int = 2
    private var currentRoll: Int {
        return firstDiceValue + secondDiceValue
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                HStack {
                    BigDice(diceValue: $firstDiceValue)
                    BigDice(diceValue: $secondDiceValue)
                }
                Text("Roll \(currentRoll)")
                    .font(.largeTitle)
                
                Button("Roll", action: roll)
                    .padding()
                    .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .background(Color.gray)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
            }
        }
    }
    
    func roll() {
        let possibleValues: [Int] = [1,2,3,4,5,6]
        self.firstDiceValue = possibleValues.randomElement() ?? 1
        self.secondDiceValue = possibleValues.randomElement() ?? 1
    }
}

struct RollDiceView_Previews: PreviewProvider {
    static var previews: some View {
        RollDiceView()
    }
}