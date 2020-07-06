//
//  ContentView.swift
//  TVBullsEye
//
//  Created by Ryan Spishock on 7/6/20.
//  Copyright © 2020 Ryan Spishock. All rights reserved.
//

import SwiftUI
import Game

struct ContentView: View {
    @ObservedObject var game = BullsEyeGame()
    
    @State var currentValue = 50.0
    @State var valueString: String = ""
    @State var showAlert = false
    
    var body: some View {
        VStack {
            Text("Guess the number:")
            TextField("1-100", text: $valueString, onEditingChanged: { _ in self.currentValue = Double(self.valueString) ?? 50.0
            })  // TextField
                .frame(width: 150.0)
            HStack {
                Text("0")
                GeometryReader { geometry in
                    ZStack {
                        Rectangle()  // line
                            .frame(height: 8.0)
                        Rectangle()  // marker
                            .frame(width: 8.0, height: 30.0)
                            .offset(x: geometry.size.width * (CGFloat(self.game.targetValue)/100.0 - 0.5), y: 0.0)
                    }  // ZStack
                }  // Geometry Reader
                Text("100")
            }  // HStack
                .padding(.horizontal)
            Button(action: {
                self.showAlert = true
                self.game.checkGuess(Int(self.currentValue))
            }) {
                Text("Hit Me!")
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Your Score"), message: Text(String(game.scoreRound)),
                      dismissButton: .default(Text("OK"), action: {
                        self.game.startNewRound()
                        self.valueString = ""
                      }))
            }  // .alert
                .padding()
            HStack {
                Text("Total Score: \(game.scoreTotal)")
                Text("Round: \(game.round)")
            } // HStack
        }  // VStack
    }  // body
}  // struct

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }  // previews
}  // struct
