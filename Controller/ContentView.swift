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
                Button("SEND") {
                    manager.send(deviceContents: DeviceContents(color: .init(red: 0.5, green: 0.5, blue: 0.5), text: "A", action: .showTextWithColor), to: .init(x: 0, y: 0))
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
