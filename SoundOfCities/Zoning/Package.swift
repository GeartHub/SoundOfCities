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
    
    var zoneManager = ZoneManager.instance
    public var packageArray: [Package] = []
    
    var latitude: Double?
    var longitude: Double?
    var radius: Double = 50
    var zoneName: String?
    
    
    var hotspotName: String?
    var hotspotHistoryInformation: String?
    var hotspotMusicInformation: String?
    var hotspotActivityInformation: String?
    var hotspotLocation: CLLocationCoordinate2D?

    func functionsStruct() -> Root {
        let fileUrl = Bundle.main.url(forResource: "Package", withExtension: "plist")!
        let data = try! Data(contentsOf: fileUrl)
        return try! PropertyListDecoder().decode(Root.self, from: data)
    }
    
    func makeTestPackage(){
        
        let information = functionsStruct()
        
        let newTestPackage = Package()
        for i in 0...information.hotspots.count-1{
            newTestPackage.hotspotName = information.hotspots[i].name
            newTestPackage.hotspotHistoryInformation = information.hotspots[i].historyDescription
            newTestPackage.hotspotMusicInformation = information.hotspots[i].musicDescription
            newTestPackage.hotspotActivityInformation = information.hotspots[i].activityDescription
            newTestPackage.hotspotLocation = CLLocationCoordinate2D(latitude: Double(information.hotspots[i].latitude)!, longitude: Double(information.hotspots[i].longitude)!)
            zoneManager.hotspots.append(Hotspot.init(from: newTestPackage))
        }
        for i in 0...information.zones.count-1{
            
            
            newTestPackage.latitude = Double(information.zones[i].latitude)
            newTestPackage.longitude =  Double(information.zones[i].longitude)
            newTestPackage.zoneName = information.zones[i].name
            
            
            newTestPackage.radius = Double(information.zones[i].radius)!
            zoneManager.zones.append(Zone.init(from: newTestPackage))
            
        }
        
        packageArray.append(newTestPackage)
    }
}
