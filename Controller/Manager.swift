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
    
    func send(deviceContents: DeviceContents, to location: DeviceLocation, time: Date = .now) {
        try! self.ref.child(location.locationString).child("commands").child(String(Int(time.timeIntervalSince1970 * 10000))).setValue(from: deviceContents)
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
    
    func startGame() {
        // Set all to black
            
        for device in onlineDevices {
            send(deviceContents: DeviceContents(color: .init(red: 0, green: 0, blue: 0), action: .showColour), to: device)
        }
        
        let startTime = Date.now.advanced(by: 0.5)
        
        let yellow = DeviceContents.Color(red: 242/255, green: 201/255, blue: 73/255)
        let orange = DeviceContents.Color(red: 247/255, green: 159/255, blue: 66/255)
        let darkOrange = DeviceContents.Color(red: 251/255, green: 119/255, blue: 59/255)
        
        // 3
        send(deviceContents: DeviceContents(color: yellow, text: "3", textColor: .init(red: 0, green: 0, blue: 0), action: .showTextWithColor), to: .init(x: 2, y: 1), time: startTime)
        
        send(deviceContents: DeviceContents(color: yellow, action: .showTextWithColor), to: .init(x: 2, y: 1), time: startTime.advanced(by: 0.33))
        
        send(deviceContents: DeviceContents(color: .init(red: 0, green: 0, blue: 0), action: .showTextWithColor), to: .init(x: 2, y: 1), time: startTime.advanced(by: 0.3))
    }
}
