//
//  ResultsView.swift
//  DiceRoller
//
//  Created by Dave Spina on 2/20/21.
//

import SwiftUI

struct ResultsView: View {
    var results = DiceResults()
    
    var body: some View {
        NavigationView {
            GeometryReader { geo in
                ScrollView {
                    VStack(alignment: .leading) {
                        ForEach(results.results, id:\.id) {result in
                            HStack {
                                Text("\(result.total)")
                                    .font(.title)
                                VStack {
                                    ForEach(result.counters, id:\.id) { counter in
                                        HStack {
                                            Text(counter.diceType)
                                                .bold()
                                            Text("\(counter.instanceCount)")
                                        }
                                    }
                                }
                                .padding()
                                .frame(alignment: .leading)
                                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                            }
                            .frame(width: geo.size.width * 0.9)
                            .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                            .padding([.horizontal], 10)
                        }
                    }
                }
                .navigationBarTitle(Text("Results"))
            }
        }
    }
}

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsView(results: DiceResults.example)
    }
}
