//
//  DeviceContents.swift
//  Wack-A-Mole
//
//  Created by Jia Chen Yee on 8/2/23.
//

import Foundation
import SwiftUI

struct DeviceContents: Codable {
    
    struct Color: Codable {
        var red: Double
        var green: Double
        var blue: Double
        
        var swiftUIColor: SwiftUI.Color {
            SwiftUI.Color(red: red, green: green, blue: blue)
        }
    }
    
    enum Action: String, Codable {
        case startGame
        case showTextWithColor
        case showColour
    }
    
    var color: Color?
    var text: String?
    var textColor: Color?
    var action: Action
}
