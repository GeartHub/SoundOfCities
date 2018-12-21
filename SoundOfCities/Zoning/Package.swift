//
//  Package.swift
//  SoundOfCities
//
//  Created by Geart Otten on 03/12/2018.
//  Copyright © 2018 Geart Otten. All rights reserved.
//

import Foundation

class Package {
    var hotspotNames: [String] = ["Oldehove", "NHL-Stenden Hogeschool"]
    public var zones: [Zone] = []
    public var zoneNames = ["drums_loop", "fx_loop", "strings_loop", "sub_loop", "synths_loop"]
    public var zoneNames2 = ["acoustic_guitar", "electroc_guitars", "percossion", "strings"]

    public var audioEffects: String?
    
    public var packageArray: [Package] = []
    var zoneManager = ZoneManager.instance
    
    var zone = Zone.instance
    public var latitude: Double?
    public var longitude: Double?
    public var radius: Double = 10
    public var zoneName: String?
    public var hotspotName: String?

    func makeTestPackage(){
        
        let newTestPackage = Package()
        
        for i in 0...zoneNames.count-1{
            newTestPackage.hotspotName = hotspotNames[1]
            newTestPackage.latitude = 53.208492
            newTestPackage.longitude =  5.794702
            newTestPackage.zoneName = zoneNames[i]
            
            newTestPackage.radius = newTestPackage.radius + 75
            zoneManager.zones.append(Zone.init(from: newTestPackage))
            
        }
        packageArray.append(newTestPackage)
        let newTestPackage2 = Package()
        
        for i in 0...zoneNames2.count-1{
            newTestPackage2.hotspotName = hotspotNames[0]
            newTestPackage2.latitude = 53.202952
            newTestPackage2.longitude =  5.790562
            newTestPackage2.zoneName = zoneNames[i]
            
            newTestPackage2.radius = newTestPackage2.radius + 75
            zoneManager.zones.append(Zone.init(from: newTestPackage2))
        }
        packageArray.append(newTestPackage2)
    }
}
