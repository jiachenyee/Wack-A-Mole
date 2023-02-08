//
//  DevicePreview.swift
//  Wack-A-Mole
//
//  Created by Jia Chen Yee on 8/2/23.
//

import SwiftUI

struct DevicePreview: View {
    
    @ObservedObject var manager: Manager
    
    var body: some View {
        VStack(spacing: 32) {
            ForEach(0..<3) { row in
                HStack {
                    ForEach(0..<5) { column in
                        ZStack(alignment: .bottomTrailing) {
                            Image(systemName: "iphone")
                                .resizable()
                                .scaledToFit()
                                .padding()
                                .opacity(0.25)
                            
                            if manager.onlineDevices.contains(where: {
                                $0.x == row && $0.y == column
                            }) {
                                Image(systemName: "checkmark.circle.fill")
                                    .symbolRenderingMode(.multicolor)
                                    .font(.system(size: 32))
                            }
                        }
                    }
                }
            }
        }
        .padding()
        .font(.system(size: 64))
    }
}
