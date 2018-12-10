//
//  ViewController.swift
//  SoundOfCities
//
//  Created by Geart Otten on 08/11/2018.
//  Copyright © 2018 Geart Otten. All rights reserved.
//

import UIKit
import AVFoundation
import CoreLocation

class MainViewController: UIViewController {
    
    var track = Track()
    var playerPool = AVAudioPlayerPool()
    var package = Package()
    var zoneManager = ZoneManager.instance
    
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareSongsAndSession()
        package.makeTestPackage()
    }
    @IBAction func playSong(_ sender: Any) {
//        track.play(count: count)
        count += 1
    }
    func prepareSongsAndSession(){
        let audioSession = AVAudioSession.sharedInstance()
            
        do{
            try audioSession.setCategory(.playback, mode: .default, options: [])

        } catch let sessionError{
                print(sessionError)
        }
    }
}
