//
//  DevicePositionPicker.swift
//  Wack-A-Mole
//
//  Created by Jia Chen Yee on 7/2/23.
//

import SwiftUI

struct DevicePositionPicker: View {
    
    @Binding var deviceLocation: DeviceLocation?
    
    var body: some View {
        VStack(spacing: 32) {
            ForEach(0..<3) { row in
                HStack {
                    ForEach(0..<5) { column in
                        Button {
                            deviceLocation = DeviceLocation(x: column, y: row)
                        } label: {
                            Image(systemName: "iphone")
                        }
                    }
                }
            }
        }
        .font(.system(size: 64))
    }
}
