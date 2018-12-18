//
//  ShapeEngine.swift
//  SoundOfCities
//
//  Created by Geart Otten on 15/11/2018.
//  Copyright © 2018 Geart Otten. All rights reserved.
//

import Foundation
import MapKit

class ShapeEngine{
    var locationManager = CLLocationManager()
    
    public func makeCircle(zone: Zone)-> MKCircle{
        let circleLocation = CLLocationCoordinate2D(latitude: zone.latitude!, longitude: zone.longitude!)
        let region = CLCircularRegion(center: circleLocation, radius: zone.radius!, identifier: zone.zoneName!)
        region.notifyOnEntry = true
        region.notifyOnExit = true
        locationManager.startMonitoring(for: region)
        
        let circle = MKCircle(center: circleLocation, radius: region.radius)
        
        return circle
    }
}
