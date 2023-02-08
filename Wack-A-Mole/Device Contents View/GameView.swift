//
//  GameView.swift
//  Wack-A-Mole
//
//  Created by Jia Chen Yee on 8/2/23.
//

import SwiftUI

struct GameView: View {
    
    @ObservedObject var manager: Manager
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var generatedNumber = Int.random(in: 1...15)

    
    var body: some View {
        VStack {
            if generatedNumber == 12 {
                Button {
                    manager.tapped()
                    generatedNumber = 1
                } label: {
                    Color(.white)
                        .ignoresSafeArea()
                }
            } else {
                Color(.black)
                    .ignoresSafeArea()
            }
        }
        .onReceive(timer) { _ in
            let newNumber = Int.random(in: 1...15)
            generatedNumber = newNumber
        }
    }
}
