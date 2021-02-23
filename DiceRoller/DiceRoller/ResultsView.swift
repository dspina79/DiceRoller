//
//  ResultsView.swift
//  DiceRoller
//
//  Created by Dave Spina on 2/20/21.
//

import SwiftUI

struct ResultsView: View {
    var results: DiceResults
    
    var body: some View {
        NavigationView {
            List(results.results, id:\.id) {result in
                HStack {
                    Text("\(result.total)")
                    VStack {
                        List(result.counters, id:\.id) { counter in
                            HStack {
                                Text(counter.diceType)
                                Text(counter.instanceCount)
                            }
                        }
                    }
                }
            }
            .navigationBarTitle(Text("Results"))
        }
    }
}

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsView(results: DiceResults.example)
    }
}
