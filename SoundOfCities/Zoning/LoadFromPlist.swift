//
//  LoadFromPlist.swift
//  SoundOfCities
//
//  Created by Geart Otten on 09/01/2019.
//  Copyright © 2019 Geart Otten. All rights reserved.
//

import Foundation

struct Root: Decodable{
    private enum Codingkeys: String, CodingKey { case hotspots, zones}
    
    let hotspots: [hotspot]
    let zones: [zone]
}

struct hotspot: Decodable {
    private enum CodingKeys: String, CodingKey {
        case name, description, latitude, longitude
    }
    
    let name: String
    let description: String
    let latitude: String
    let longitude: String
}

struct zones: Decodable {
    private enum CodingKeys : String, CodingKey { case zone }
    
    let zone: zone
}
struct zone: Decodable {
    private enum CodingKeys : String, CodingKey { case name, latitude, longitude, radius }
    
    let name: String
    let latitude: String
    let longitude: String
    let radius: String
}
