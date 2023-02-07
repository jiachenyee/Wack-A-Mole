//
//  Manager.swift
//  Wack-A-Mole
//
//  Created by Jia Chen Yee on 7/2/23.
//

import Foundation

class Manager: ObservableObject {
    @Published var location: DeviceLocation? {
        didSet {
            tapped()
        }
    }
    
    func tapped() {
        
    }
}
