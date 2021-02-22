//
//  ContentView.swift
//  DiceRoller
//
//  Created by Dave Spina on 2/20/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            TabView {
                RollDiceView()
                    .tabItem {
                        Image(systemName: "die.face.5.fill")
                            .resizable()
                            .scaledToFit()
                        Text("Roll")
                    }
                ResultsView()
                    .tabItem {
                        Image(systemName: "list.bullet.rectangle")
                        Text("Results")
                    }
                SettingsView()
                    .tabItem {
                        Image(systemName: "list.dash")
                        Text("Settings")
                    }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
