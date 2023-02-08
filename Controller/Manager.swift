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
    
    @Published var score = 0
    @Published var isPlaying = false
    
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
            if isPlaying {
                score += 1
            }
            
            guard let snapshotValue = snapshot.value as? NSDictionary else { return }
            onlineDevices = snapshotValue.allKeys.map { key in
                let split = (key as! String).split(separator: "x")
                
                return DeviceLocation(x: Int(split[0])!, y: Int(split[1])!)
            }
            
            let values = snapshotValue.allKeys.compactMap { key in
                let key = key as! String
                let embeddedValues = snapshotValue.value(forKey: key) as! NSDictionary
                
                let lastTapTime = embeddedValues.value(forKey: "lastTap") as? Double
                
                if let lastTapTime {
                    let howLongAgo = abs(Date(timeIntervalSince1970: lastTapTime).timeIntervalSinceNow)
                    
                    if howLongAgo < 0.5 {
                        return (key, howLongAgo)
                    }
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
        score = 0
        for device in onlineDevices {
            send(deviceContents: DeviceContents(color: .init(red: 0, green: 0, blue: 0), action: .showColour), to: device)
        }
        
        let startTime = Date.now.advanced(by: 0.5)
        
        let yellow = DeviceContents.Color(red: 242/255, green: 201/255, blue: 73/255)
        let orange = DeviceContents.Color(red: 247/255, green: 159/255, blue: 66/255)
        let darkOrange = DeviceContents.Color(red: 251/255, green: 119/255, blue: 59/255)
        
        // 3
        send(deviceContents: DeviceContents(color: yellow, text: "3", textColor: .init(red: 0, green: 0, blue: 0), action: .showTextWithColor), to: .init(x: 2, y: 1), time: startTime)
        
        send(deviceContents: DeviceContents(color: yellow, action: .showTextWithColor), to: .init(x: 1, y: 0), time: startTime.advanced(by: 0.33))
        send(deviceContents: DeviceContents(color: yellow, action: .showTextWithColor), to: .init(x: 1, y: 1), time: startTime.advanced(by: 0.33))
        send(deviceContents: DeviceContents(color: yellow, action: .showTextWithColor), to: .init(x: 1, y: 2), time: startTime.advanced(by: 0.33))
        send(deviceContents: DeviceContents(color: yellow, action: .showTextWithColor), to: .init(x: 2, y: 0), time: startTime.advanced(by: 0.33))
        send(deviceContents: DeviceContents(color: yellow, action: .showTextWithColor), to: .init(x: 2, y: 2), time: startTime.advanced(by: 0.33))
        send(deviceContents: DeviceContents(color: yellow, action: .showTextWithColor), to: .init(x: 3, y: 0), time: startTime.advanced(by: 0.33))
        send(deviceContents: DeviceContents(color: yellow, action: .showTextWithColor), to: .init(x: 3, y: 1), time: startTime.advanced(by: 0.33))
        send(deviceContents: DeviceContents(color: yellow, action: .showTextWithColor), to: .init(x: 3, y: 2), time: startTime.advanced(by: 0.33))
        
        send(deviceContents: DeviceContents(color: yellow, action: .showTextWithColor), to: .init(x: 4, y: 2), time: startTime.advanced(by: 0.66))
        send(deviceContents: DeviceContents(color: yellow, action: .showTextWithColor), to: .init(x: 4, y: 1), time: startTime.advanced(by: 0.66))
        send(deviceContents: DeviceContents(color: yellow, action: .showTextWithColor), to: .init(x: 4, y: 0), time: startTime.advanced(by: 0.66))
        send(deviceContents: DeviceContents(color: yellow, action: .showTextWithColor), to: .init(x: 0, y: 2), time: startTime.advanced(by: 0.66))
        send(deviceContents: DeviceContents(color: yellow, action: .showTextWithColor), to: .init(x: 0, y: 1), time: startTime.advanced(by: 0.66))
        send(deviceContents: DeviceContents(color: yellow, action: .showTextWithColor), to: .init(x: 0, y: 0), time: startTime.advanced(by: 0.66))

        send(deviceContents: DeviceContents(color: orange, text: "2", textColor: .init(red: 0, green: 0, blue: 0), action: .showTextWithColor), to: .init(x: 2, y: 1), time: startTime.advanced(by: 1))
        
        send(deviceContents: DeviceContents(color: orange, action: .showTextWithColor), to: .init(x: 1, y: 0), time: startTime.advanced(by: 1.33))
        send(deviceContents: DeviceContents(color: orange, action: .showTextWithColor), to: .init(x: 1, y: 1), time: startTime.advanced(by: 1.33))
        send(deviceContents: DeviceContents(color: orange, action: .showTextWithColor), to: .init(x: 1, y: 2), time: startTime.advanced(by: 1.33))
        send(deviceContents: DeviceContents(color: orange, action: .showTextWithColor), to: .init(x: 2, y: 0), time: startTime.advanced(by: 1.33))
        send(deviceContents: DeviceContents(color: orange, action: .showTextWithColor), to: .init(x: 2, y: 2), time: startTime.advanced(by: 1.33))
        send(deviceContents: DeviceContents(color: orange, action: .showTextWithColor), to: .init(x: 3, y: 0), time: startTime.advanced(by: 1.33))
        send(deviceContents: DeviceContents(color: orange, action: .showTextWithColor), to: .init(x: 3, y: 1), time: startTime.advanced(by: 1.33))
        send(deviceContents: DeviceContents(color: orange, action: .showTextWithColor), to: .init(x: 3, y: 2), time: startTime.advanced(by: 1.33))
        
        send(deviceContents: DeviceContents(color: orange, action: .showTextWithColor), to: .init(x: 4, y: 2), time: startTime.advanced(by: 1.66))
        send(deviceContents: DeviceContents(color: orange, action: .showTextWithColor), to: .init(x: 4, y: 1), time: startTime.advanced(by: 1.66))
        send(deviceContents: DeviceContents(color: orange, action: .showTextWithColor), to: .init(x: 4, y: 0), time: startTime.advanced(by: 1.66))
        send(deviceContents: DeviceContents(color: orange, action: .showTextWithColor), to: .init(x: 0, y: 2), time: startTime.advanced(by: 1.66))
        send(deviceContents: DeviceContents(color: orange, action: .showTextWithColor), to: .init(x: 0, y: 1), time: startTime.advanced(by: 1.66))
        send(deviceContents: DeviceContents(color: orange, action: .showTextWithColor), to: .init(x: 0, y: 0), time: startTime.advanced(by: 1.66))

        send(deviceContents: DeviceContents(color: darkOrange, text: "1", textColor: .init(red: 1, green: 1, blue: 1), action: .showTextWithColor), to: .init(x: 2, y: 1), time: startTime.advanced(by: 2))
        
        send(deviceContents: DeviceContents(color: darkOrange, action: .showTextWithColor), to: .init(x: 1, y: 0), time: startTime.advanced(by: 2.33))
        send(deviceContents: DeviceContents(color: darkOrange, action: .showTextWithColor), to: .init(x: 1, y: 1), time: startTime.advanced(by: 2.33))
        send(deviceContents: DeviceContents(color: darkOrange, action: .showTextWithColor), to: .init(x: 1, y: 2), time: startTime.advanced(by: 2.33))
        send(deviceContents: DeviceContents(color: darkOrange, action: .showTextWithColor), to: .init(x: 2, y: 0), time: startTime.advanced(by: 2.33))
        send(deviceContents: DeviceContents(color: darkOrange, action: .showTextWithColor), to: .init(x: 2, y: 2), time: startTime.advanced(by: 2.33))
        send(deviceContents: DeviceContents(color: darkOrange, action: .showTextWithColor), to: .init(x: 3, y: 0), time: startTime.advanced(by: 2.33))
        send(deviceContents: DeviceContents(color: darkOrange, action: .showTextWithColor), to: .init(x: 3, y: 1), time: startTime.advanced(by: 2.33))
        send(deviceContents: DeviceContents(color: darkOrange, action: .showTextWithColor), to: .init(x: 3, y: 2), time: startTime.advanced(by: 2.33))
        
        send(deviceContents: DeviceContents(color: darkOrange, action: .showTextWithColor), to: .init(x: 4, y: 2), time: startTime.advanced(by: 2.66))
        send(deviceContents: DeviceContents(color: darkOrange, action: .showTextWithColor), to: .init(x: 4, y: 1), time: startTime.advanced(by: 2.66))
        send(deviceContents: DeviceContents(color: darkOrange, action: .showTextWithColor), to: .init(x: 4, y: 0), time: startTime.advanced(by: 2.66))
        send(deviceContents: DeviceContents(color: darkOrange, action: .showTextWithColor), to: .init(x: 0, y: 2), time: startTime.advanced(by: 2.66))
        send(deviceContents: DeviceContents(color: darkOrange, action: .showTextWithColor), to: .init(x: 0, y: 1), time: startTime.advanced(by: 2.66))
        send(deviceContents: DeviceContents(color: darkOrange, action: .showTextWithColor), to: .init(x: 0, y: 0), time: startTime.advanced(by: 2.66))
        
        send(deviceContents: DeviceContents(action: .startGame), to: .init(x: 2, y: 1), time: startTime.advanced(by: 3))
        send(deviceContents: DeviceContents(action: .startGame), to: .init(x: 1, y: 0), time: startTime.advanced(by: 3))
        send(deviceContents: DeviceContents(action: .startGame), to: .init(x: 1, y: 1), time: startTime.advanced(by: 3))
        send(deviceContents: DeviceContents(action: .startGame), to: .init(x: 1, y: 2), time: startTime.advanced(by: 3))
        send(deviceContents: DeviceContents(action: .startGame), to: .init(x: 2, y: 0), time: startTime.advanced(by: 3))
        send(deviceContents: DeviceContents(action: .startGame), to: .init(x: 2, y: 2), time: startTime.advanced(by: 3))
        send(deviceContents: DeviceContents(action: .startGame), to: .init(x: 3, y: 0), time: startTime.advanced(by: 3))
        send(deviceContents: DeviceContents(action: .startGame), to: .init(x: 3, y: 1), time: startTime.advanced(by: 3))
        send(deviceContents: DeviceContents(action: .startGame), to: .init(x: 3, y: 2), time: startTime.advanced(by: 3))
        send(deviceContents: DeviceContents(action: .startGame), to: .init(x: 4, y: 2), time: startTime.advanced(by: 3))
        send(deviceContents: DeviceContents(action: .startGame), to: .init(x: 4, y: 1), time: startTime.advanced(by: 3))
        send(deviceContents: DeviceContents(action: .startGame), to: .init(x: 4, y: 0), time: startTime.advanced(by: 3))
        send(deviceContents: DeviceContents(action: .startGame), to: .init(x: 0, y: 2), time: startTime.advanced(by: 3))
        send(deviceContents: DeviceContents(action: .startGame), to: .init(x: 0, y: 1), time: startTime.advanced(by: 3))
        send(deviceContents: DeviceContents(action: .startGame), to: .init(x: 0, y: 0), time: startTime.advanced(by: 3))
        
        Timer.scheduledTimer(withTimeInterval: 4, repeats: false) { _ in
            self.score = 0
            isPlaying = true
        }
        
        send(deviceContents: DeviceContents(text: "G", action: .showTextWithColor), to: .init(x: 0, y: 0), time: startTime.advanced(by: 90))
        send(deviceContents: DeviceContents(text: "A", action: .showTextWithColor), to: .init(x: 1, y: 0), time: startTime.advanced(by: 90))
        send(deviceContents: DeviceContents(text: "M", action: .showTextWithColor), to: .init(x: 2, y: 0), time: startTime.advanced(by: 90))
        send(deviceContents: DeviceContents(text: "E", action: .showTextWithColor), to: .init(x: 3, y: 0), time: startTime.advanced(by: 90))
        send(deviceContents: DeviceContents(text: "", action: .showTextWithColor), to: .init(x: 4, y: 0), time: startTime.advanced(by: 90))

        send(deviceContents: DeviceContents(text: "O", action: .showTextWithColor), to: .init(x: 0, y: 1), time: startTime.advanced(by: 90))
        send(deviceContents: DeviceContents(text: "V", action: .showTextWithColor), to: .init(x: 1, y: 1), time: startTime.advanced(by: 90))
        send(deviceContents: DeviceContents(text: "E", action: .showTextWithColor), to: .init(x: 2, y: 1), time: startTime.advanced(by: 90))
        send(deviceContents: DeviceContents(text: "R", action: .showTextWithColor), to: .init(x: 3, y: 1), time: startTime.advanced(by: 90))
        send(deviceContents: DeviceContents(text: "!", action: .showTextWithColor), to: .init(x: 4, y: 1), time: startTime.advanced(by: 90))
        
        Timer.scheduledTimer(withTimeInterval: 93.5, repeats: false) { _ in
            isPlaying = false
            let score = Array("0000" + String(self.score)).reversed().map { String($0) }
            
            self.send(deviceContents: DeviceContents(text: score[0], action: .showTextWithColor), to: .init(x: 0, y: 2))
            self.send(deviceContents: DeviceContents(text: score[1], action: .showTextWithColor), to: .init(x: 1, y: 2))
            self.send(deviceContents: DeviceContents(text: score[2], action: .showTextWithColor), to: .init(x: 2, y: 2))
            self.send(deviceContents: DeviceContents(text: score[3], action: .showTextWithColor), to: .init(x: 3, y: 2))
            self.send(deviceContents: DeviceContents(text: score[4], action: .showTextWithColor), to: .init(x: 4, y: 2))
        }
        
    }
}
