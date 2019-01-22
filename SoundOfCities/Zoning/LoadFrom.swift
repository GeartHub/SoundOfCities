//
//  LoadFromPlist.swift
//  SoundOfCities
//
//  Created by Geart Otten on 09/01/2019.
//  Copyright © 2019 Geart Otten. All rights reserved.
//

import Foundation
struct audioZones: Decodable {
    let radius: String?
    let coords: [Coordinates]
    let tracks: Tracks
    let hotspots: [hotspot]?
}
struct Coordinates: Decodable {
    let lat: String
    let lng: String
}
struct Tracks: Decodable {
    var name: String
    var audio_url: String
}
struct hotspot: Decodable {
    private enum CodingKeys: String, CodingKey {
        case name, historyDescription, musicDescription, activityDescription, latitude, longitude
    }
    
    let name: String
    let historyDescription: String
    let musicDescription: String
    let activityDescription: String
    let latitude: String
    let longitude: String
}
