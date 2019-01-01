//
//  ZoneManager.swift
//  SoundOfCities
//
//  Created by Geart Otten on 15/11/2018.
//  Copyright © 2018 Geart Otten. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

class ZoneManager{
    var zones: [Zone] = []
    var hotspots: [Hotspot] = []
    
    static let instance: ZoneManager = ZoneManager()
    
    func find(with hotspotName: String)->Hotspot?{
        if let hotspot = hotspots.first(where: {$0.name  == hotspotName}){
            return hotspot
        }
        return nil
    }
}
