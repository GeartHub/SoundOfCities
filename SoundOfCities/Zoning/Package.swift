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
    let fileManager = FileManager()
    
    var information: [audioZones] = []

    func functionsStruct() -> [audioZones] {
        let fileUrl = Bundle.main.url(forResource: "audioZones", withExtension: "json")!
        let data = try! Data(contentsOf: fileUrl)
        return try! JSONDecoder().decode([audioZones].self, from: data)
    }
    
    func getInformationJSON()->[audioZones]{
        //TODO: Name of collection here.
        let filepath = getDocumentsDirectory().appendingPathComponent("collection", isDirectory: true).appendingPathComponent("audioZones.json")
        let data = try! Data(contentsOf: filepath)
        return try! JSONDecoder().decode([audioZones].self, from:data)
    }
    
    func deletePackage(fileURL: URL){
        do{
            try fileManager.removeItem(at: fileURL)
        } catch {
            print(error)
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
    func unpackFolder(from package: URL){
        var currentWorkingPath = getDocumentsDirectory()
        var destinationURL = currentWorkingPath
        
        //TODO: Name of the collection here.
        destinationURL.appendPathComponent("collection")
        currentWorkingPath.appendPathComponent(package.absoluteString)
        print(currentWorkingPath)
        do {
            try fileManager.createDirectory(at: destinationURL, withIntermediateDirectories: true, attributes: nil)
            try fileManager.unzipItem(at: currentWorkingPath, to: destinationURL)
            deletePackage(fileURL: currentWorkingPath)
            makeTestPackage(type: .webData)
        } catch {
            deletePackage(fileURL: currentWorkingPath)
            makeTestPackage(type: .webData)
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    func makeTestPackage(type: DataType){
        
        if type == .webData{
            information = getInformationJSON()
        }
        if type == .testData{
            information = functionsStruct()
        }
        
        for audiozone in information{
            zoneManager.zones.append(Zone.init(with: audiozone))
            if audiozone.hotspots != nil{
                for hotspot in audiozone.hotspots!{
                    zoneManager.hotspots.append(Hotspot.init(with: hotspot))
                }
            }
        }
        NotificationCenter.default.post(name: .finishedPackageDownload, object: nil)
    }
}

enum DataType{
    case testData
    
    case webData
}
extension Notification.Name {
    static let finishedPackageDownload = Notification.Name("finishedPackage")
}
