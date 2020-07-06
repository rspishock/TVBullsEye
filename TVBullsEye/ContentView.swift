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
            })
                .frame(width: 150.0)
            HStack {
                Text("0")
                GeometryReader { geometry in
                    ZStack {
                        Rectangle()
                            .frame(height: 8.0)
                        Rectangle()
                            .frame(width: 8.0, height: 30.0)
                            .offset(x: geometry.size.width * (CGFloat(self.game.targetValue)/100.0 - 0.5), y: 0.0)
                    }
                }
                Text("100")
            }
            .padding(.horizontal)
        }
    }
}
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
}
