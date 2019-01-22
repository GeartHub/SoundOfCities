//
//  Zone.swift
//  SoundOfCities
//
//  Created by Geart Otten on 03/12/2018.
//  Copyright © 2018 Geart Otten. All rights reserved.
//

import Foundation

final class Zone{
    
    static let instance: Zone = Zone()
    
    public var latitude: Double?
    public var longitude: Double?
    public var radius: Double?
    public var zoneName: String?
    
    private init() {}
    
//    init(from: Package){
//        latitude = from.latitude
//        longitude = from.longitude
//        radius = from.radius
//        zoneName = from.zoneName
//    }
    
    init(with audiozone: audioZones) {
        latitude = Double(audiozone.coords[0].lat)
        longitude = Double(audiozone.coords[0].lng)
        radius = Double(audiozone.radius!)
        zoneName = audiozone.tracks.audio_url.replacingOccurrences(of: "audio/", with: "", options: .caseInsensitive, range: nil)
    }
}
