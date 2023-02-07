//
//  DeviceLocation.swift
//  Wack-A-Mole
//
//  Created by Jia Chen Yee on 7/2/23.
//

import Foundation

struct DeviceLocation {
    var x: Int
    var y: Int
    
    var locationString: String {
        "\(x)x\(y)"
    }
}
