//
//  Manager.swift
//  Controller
//
//  Created by Jia Chen Yee on 8/2/23.
//

import Foundation
import FirebaseDatabase
import FirebaseDatabaseSwift

class Manager: ObservableObject {
    
    var ref: DatabaseReference!
    
    @Published var onlineDevices: [DeviceLocation] = []
    @Published var taps: [DeviceLocation] = []
    
    func send(deviceContents: DeviceContents, to location: DeviceLocation) {        
        try! self.ref.child(location.locationString).child("commands").child(String(Int(Date.now.timeIntervalSince1970 * 10000))).setValue(from: deviceContents)
    }
    
    init() {
        ref = Database.database(url: "https://wackamole-919f8-default-rtdb.asia-southeast1.firebasedatabase.app").reference()
        resetDB()
        observe()
    }
    
    func observe() {
        ref.observe(.value) { [self] snapshot  in
            guard let snapshotValue = snapshot.value as? NSDictionary else { return }
            
            onlineDevices = snapshotValue.allKeys.map { key in
                let split = (key as! String).split(separator: "x")
                
                return DeviceLocation(x: Int(split[0])!, y: Int(split[1])!)
            }
            
            let values = snapshotValue.allKeys.compactMap { key in
                let key = key as! String
                let embeddedValues = snapshotValue.value(forKey: key) as! NSDictionary
                
                let lastTapTime = embeddedValues.value(forKey: "lastTap") as! Double
                
                let howLongAgo = abs(Date(timeIntervalSince1970: lastTapTime).timeIntervalSinceNow)
                
                if howLongAgo < 0.5 {
                    return (key, howLongAgo)
                }
                
                return nil
            }
            
            print(values)
        }
    }
    
    func resetDB() {
        ref.removeValue { error, ref in
            if let error {
                print(error.localizedDescription)
            }
        }
    }
}
