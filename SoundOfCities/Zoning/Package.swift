//
//  Package.swift
//  SoundOfCities
//
//  Created by Geart Otten on 03/12/2018.
//  Copyright © 2018 Geart Otten. All rights reserved.
//

import Foundation
import CoreLocation

struct audioZones: Decodable {
    let radius: String?
    let coords: [Coordinates]
    let tracks: Tracks
}
struct Coordinates: Decodable {
    let lat: String
    let lng: String
}
struct Tracks: Decodable {
    var name: String
    var audio_url: String
}

class Package {
    
    var zoneManager = ZoneManager.instance
    public var packageArray: [Package] = []
    let fileManager = FileManager()
    
    var latitude: Double?
    var longitude: Double?
    var radius: Double?
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
    
    func getInformationJSON()->[audioZones]{
        let filepath = getDocumentsDirectory().appendingPathComponent("test", isDirectory: true).appendingPathComponent("audioZones.json")
        let data = try! Data(contentsOf: filepath)
        return try! JSONDecoder().decode([audioZones].self, from:data)
    }
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    func unpackFolder(from package: URL){
        var currentWorkingPath = getDocumentsDirectory()
        var destinationURL = currentWorkingPath
        print(currentWorkingPath)
        destinationURL.appendPathComponent("test")
        currentWorkingPath.appendPathComponent(package.absoluteString)
        do {
            try fileManager.createDirectory(at: destinationURL, withIntermediateDirectories: true, attributes: nil)
            try fileManager.unzipItem(at: currentWorkingPath, to: destinationURL)
            makeTestPackage()
        } catch {
            makeTestPackage()
        }
    }
    func download(){
        let saveAsUrl = URL(string: "collection.zip")
        if let packageUrl = URL(string: "http://resonance.webdesign-joure.nl/collection/export/1") {
            
            // then lets create your document folder url
            let documentsDirectoryURL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            
            // lets create your destination file url
            let destinationUrl =  documentsDirectoryURL.appendingPathComponent((saveAsUrl?.lastPathComponent)!)
            
            
            // to check if it exists before downloading it
            if FileManager.default.fileExists(atPath: destinationUrl.path) {
                print("The file already exists at path")
                self.unpackFolder(from: saveAsUrl!)
                
                // if the file doesn't exist
            } else {
                
                // you can use NSURLSession.sharedSession to download the data asynchronously
                URLSession.shared.downloadTask(with: packageUrl, completionHandler: { (location, response, error) -> Void in
                    guard let location = location, error == nil else { return }
                    do {
                        // after downloading your file you need to move it to your destination url
                        try FileManager.default.moveItem(at: location, to: destinationUrl)
                        self.unpackFolder(from: saveAsUrl!)
                    } catch let error as NSError {
                        print(error.localizedDescription)
                    }
                    
                }).resume()
            }
            
        }
    }
    
    func makeTestPackage(){
        
        let information = functionsStruct()
        let information2 = getInformationJSON()
        
        let newTestPackage = Package()
        for i in 0...information.hotspots.count-1{
            newTestPackage.hotspotName = information.hotspots[i].name
            newTestPackage.hotspotHistoryInformation = information.hotspots[i].historyDescription
            newTestPackage.hotspotMusicInformation = information.hotspots[i].musicDescription
            newTestPackage.hotspotActivityInformation = information.hotspots[i].activityDescription
            newTestPackage.hotspotLocation = CLLocationCoordinate2D(latitude: Double(information.hotspots[i].latitude)!, longitude: Double(information.hotspots[i].longitude)!)
            zoneManager.hotspots.append(Hotspot.init(from: newTestPackage))
        }
        for i in 0...information2.count-1{
            
            
            newTestPackage.latitude = Double(information2[i].coords[0].lat)
            newTestPackage.longitude =  Double(information2[i].coords[0].lng)
            let newName = information2[i].tracks.audio_url.replacingOccurrences(of: "audio/", with: "", options: .caseInsensitive, range: nil)
            newTestPackage.zoneName = newName
            print(newName)
            let radius = information2[i].radius!
            newTestPackage.radius = Double(radius)
            
            zoneManager.zones.append(Zone.init(from: newTestPackage))
            
        }
        packageArray.append(newTestPackage)
        NotificationCenter.default.post(name: .finishedPackageDownload, object: nil)
    }
}
extension Notification.Name {
    static let finishedPackageDownload = Notification.Name("finishedPackage")
}
