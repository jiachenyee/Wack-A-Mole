//
//  ContentView.swift
//  Controller
//
//  Created by Jia Chen Yee on 8/2/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var manager = Manager()
    
    var body: some View {
        GeometryReader { proxy in
            HStack(spacing: 0) {
                Spacer()
                VStack {
                    Text("\(manager.score)")
                        .font(.system(size: 32))
                    Button("START") {
                        manager.startGame()
                    }
                }
                Spacer()
                Divider()
                DevicePreview(manager: manager)
                    .frame(width: proxy.size.width / 2)
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
