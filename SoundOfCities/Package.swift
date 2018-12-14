//
//  Package.swift
//  SoundOfCities
//
//  Created by Geart Otten on 03/12/2018.
//  Copyright © 2018 Geart Otten. All rights reserved.
//

import Foundation

class Package {
    public var zones: [Zone] = []
    public var zoneNames = ["drums_loop", "fx_loop", "strings_loop", "sub_loop", "synths_loop"]
    public var audioEffects: String?
    
    public var packageArray: [Package] = []
    var zoneManager = ZoneManager.instance
    
    var zone = Zone.instance

    func makeTestPackage(){
        var newTestPackage = Package()
        var newTestZone = Zone.instance
        newTestZone.radius = 50
        
        for i in 0...4{
            newTestZone.latitude = 53.21168578930956
            newTestZone.longitude = 5.79
            newTestZone.zoneName = zoneNames[i]
            
            packageArray.append(newTestPackage)
            newTestZone.radius = newTestZone.radius! + 500
            
            zoneManager.zones.append(Zone.init(from: packageArray[i]))
            zones.append(Zone.init(from: packageArray[i]))
        }
    }
}
