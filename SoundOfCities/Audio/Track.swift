//
//  Track.swift
//  SoundOfCities
//
//  Created by Geart Otten on 19/11/2018.
//  Copyright © 2018 Geart Otten. All rights reserved.
//

import Foundation
import AVFoundation
import MediaPlayer

class Track: NSObject{
    var playerPool = AVAudioPlayerPool()
//    var viewController = MainViewController()
    
    func play(name: String){
        print(name)
        let urlPath = Bundle.main.path(forResource: name, ofType: "mp3")
        let fileURL = URL(fileURLWithPath: urlPath!)
        let somePlayer = playerPool.playerWithURL(url: fileURL)
        somePlayer?.delegate = self
        somePlayer?.prepareToPlay()
        somePlayer?.play()
        
    }
}
extension Track: AVAudioPlayerDelegate{
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        print("test")
    }
}
