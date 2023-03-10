//
//  ContentView.swift
//  Wack-A-Mole
//
//  Created by Jia Chen Yee on 7/2/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var manager = Manager()
    
    var body: some View {
        if manager.location == nil {
            DevicePositionPicker(deviceLocation: $manager.location)
        } else {
            DeviceContentsView(manager: manager)
        }
    }
}
