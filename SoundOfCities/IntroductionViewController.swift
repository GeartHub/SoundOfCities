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

class IntroductionViewController: UIViewController {
    
    @IBOutlet weak var nextButton: UIButton!
    var track = Track()
    var playerPool = AVAudioPlayerPool()
    var package = Package()
    var zoneManager = ZoneManager.instance
    
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareSongsAndSession()
        package.makeTestPackage()
        nextButton.imageEdgeInsets = UIEdgeInsets(top: 10,left: 5,bottom: 10,right: 5)
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
