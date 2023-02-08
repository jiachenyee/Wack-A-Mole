//
//  ColorTextView.swift
//  Wack-A-Mole
//
//  Created by Jia Chen Yee on 8/2/23.
//

import SwiftUI

struct ColorTextView: View {
    
    var deviceContents: DeviceContents
    
    var body: some View {
        ZStack {
            if let color = deviceContents.color {
                color.swiftUIColor
                    .edgesIgnoringSafeArea(.all)
            } else {
                Color.white
                    .edgesIgnoringSafeArea(.all)
            }
            
            if let text = deviceContents.text {
                Text(text)
                    .font(.system(size: 500, design: .monospaced))
                    .foregroundColor(deviceContents.textColor?.swiftUIColor ?? .black)
            }
        }
    }
}
