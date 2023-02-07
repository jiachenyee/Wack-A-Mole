//
//  Manager.swift
//  Wack-A-Mole
//
//  Created by Jia Chen Yee on 7/2/23.
//

import Foundation
import FirebaseDatabase
import FirebaseDatabaseSwift

class Manager: ObservableObject {
    
    var ref: DatabaseReference!
    
    @Published var deviceContents: DeviceContents?
    @Published var location: DeviceLocation? {
        didSet {
            tapped()
            observeLocation()
        }
    }
    
    func tapped() {
        guard let location else { return }
        ref = Database.database(url: "https://wackamole-919f8-default-rtdb.asia-southeast1.firebasedatabase.app").reference()
        self.ref.child(location.locationString).child("lastTap").setValue(Date.now.timeIntervalSince1970)
    }
    
    func observeLocation() {
        guard let location else { return }
        ref.child(location.locationString).child("commands").observe(.childAdded) { snapshot in
            guard let deviceContents = try? snapshot.data(as: DeviceContents.self) else { return }
            
            let time = abs(Date(timeIntervalSince1970: Double(snapshot.key)!).timeIntervalSinceNow)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + time) {
                self.deviceContents = deviceContents
            }
        }
    }
}
