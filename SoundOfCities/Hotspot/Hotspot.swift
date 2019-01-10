//
//  Hotspot.swift
//  SoundOfCities
//
//  Created by Geart Otten on 28/12/2018.
//  Copyright © 2018 Geart Otten. All rights reserved.
//

import Foundation
import CoreLocation

final class Hotspot{
    var zonemanager = ZoneManager.instance
    
    public var name: String?
    public var historyInformation: String?
    public var musicInformation: String?
    public var activityInformation: String?
    public var location: CLLocationCoordinate2D?
    
    private init() {}
    
    init(from: Package){
        name = from.hotspotName
        historyInformation = from.hotspotHistoryInformation
        musicInformation = from.hotspotMusicInformation
        activityInformation = from.hotspotActivityInformation
        location = from.hotspotLocation
    }
    
}
