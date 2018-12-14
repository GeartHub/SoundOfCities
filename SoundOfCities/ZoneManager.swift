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
    var lastZoneName: String = ""
    var circle = MKCircle()
    
    var zones: [Zone] = []
    
    static let instance: ZoneManager = ZoneManager()

}
