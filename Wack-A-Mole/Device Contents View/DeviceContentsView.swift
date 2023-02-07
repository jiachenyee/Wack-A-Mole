//
//  DeviceContentsView.swift
//  Wack-A-Mole
//
//  Created by Jia Chen Yee on 7/2/23.
//

import SwiftUI

struct DeviceContentsView: View {
    
    @ObservedObject var manager: Manager
    
    var body: some View {
        if let contents = manager.deviceContents {
            switch contents.action {
            case .startGame:
                Text("AA")
            case .showColour, .showTextWithColor:
                Text("AAA")
            }
        } else {
            ProgressView()
        }
    }
}
