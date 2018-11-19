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

    var playerQueue = AVQueuePlayer()
    var player = AVPlayer()
//    var playerLooper = AVPlayerLooper()
    
    
    var songArray: [String] = ["arpeggio_100", "brass_100", "percussion_100_1", "percussion_100_2", "strings_100"]
    
    var count = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for _ in songArray{
            let urlPath = Bundle.main.path(forResource: songArray[count], ofType: "mp3")
            let fileURL = URL(fileURLWithPath: urlPath!)
            let playerItem = AVPlayerItem(url: fileURL)
            playerQueue.insert(playerItem, after: nil)
            count += 1
        }
        prepareSongsAndSession()
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

