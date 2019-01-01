//
//  Package.swift
//  SoundOfCities
//
//  Created by Geart Otten on 03/12/2018.
//  Copyright © 2018 Geart Otten. All rights reserved.
//

import Foundation
import CoreLocation

class Package {
    var fakeHotspot: [String] = ["Oldehove", "The Oldehove is a leaning and unfinished church tower in the medieval centre of the Dutch city of Leeuwarden."]
    
    var fakeHotspot2 = ["NHL-Stenden Hogeschool", "NHL Stenden Hogeschool is a educational institution with campuses all around the world."]
    var fakeHotspotLocation = [53.202952, 5.790562]
    var fakeHotspotLocation2 = [53.208492, 5.794702]

    
    public var fakeZoneNames = ["synths_loop", "fx_loop", "strings_loop", "sub_loop", "drums_loop"]
    public var fakeZoneNames2 = ["acoustic_guitar", "electric_guitar", "percussion", "strings"]

//    public var audioEffects: String?
    
    
    var zoneManager = ZoneManager.instance
    public var packageArray: [Package] = []
    
    var latitude: Double?
    var longitude: Double?
    var radius: Double = 10
    var zoneName: String?
    
    
    var hotspotName: String?
    var hotspotInformation: String?
    var hotspotLocation: CLLocationCoordinate2D?

    func makeTestPackage(){
        
        let newTestPackage = Package()
        newTestPackage.hotspotName = fakeHotspot[0]
        newTestPackage.hotspotInformation = fakeHotspot[1]
        newTestPackage.hotspotLocation = CLLocationCoordinate2D(latitude: fakeHotspotLocation[0], longitude: fakeHotspotLocation[1])
        
        for i in 0...fakeZoneNames.count-1{
            
            
            newTestPackage.latitude = 53.208492
            newTestPackage.longitude =  5.794702
            newTestPackage.zoneName = fakeZoneNames[i]
            
            
            newTestPackage.radius = newTestPackage.radius + 100
            zoneManager.zones.append(Zone.init(from: newTestPackage))
            
        }
        zoneManager.hotspots.append(Hotspot.init(from: newTestPackage))
        packageArray.append(newTestPackage)
        
        
        
        
        let newTestPackage2 = Package()
        newTestPackage2.hotspotName = fakeHotspot2[0]
        newTestPackage2.hotspotInformation = fakeHotspot2[1]
        newTestPackage2.hotspotLocation = CLLocationCoordinate2D(latitude: fakeHotspotLocation2[0], longitude: fakeHotspotLocation2[1])
        for i in 0...fakeZoneNames2.count-1{
//            newTestPackage2.hotspotName = hotspotNames[0]
//            newTestPackage.hotspotInformation = hotspotInformations[0]
            newTestPackage2.latitude = 53.202952
            newTestPackage2.longitude =  5.790562
            newTestPackage2.zoneName = fakeZoneNames2[i]
            
            newTestPackage2.radius = newTestPackage2.radius + 75
            zoneManager.zones.append(Zone.init(from: newTestPackage2))
        }
        zoneManager.hotspots.append(Hotspot.init(from: newTestPackage2))
        packageArray.append(newTestPackage2)
    }
}
