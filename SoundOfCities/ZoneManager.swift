//
//  ZoneManager.swift
//  SoundOfCities
//
//  Created by Geart Otten on 15/11/2018.
//  Copyright © 2018 Geart Otten. All rights reserved.
//

import Foundation
import CoreLocation

class ZoneManager{
    func checkZoneChange(){
        var zoneLocation: CLLocation = CLLocation(latitude: fakeCircleLocation.latitude, longitude: fakeCircleLocation.longitude)
        
        var userLocation: CLLocation = CLLocation(latitude: locationValue.latitude, longitude: locationValue.longitude)
        
        if userLocation.distance(from: zoneLocation) > circle.radius{
            print("user left zone")
        }else{
            print("user is in zone")
        }
    }
    func didChangeZone(){
        
    }
    
}
