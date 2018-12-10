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
    
    var tracksArray:[String] = ["arpeggio_100", "brass_100", "percussion_100_1", "percussion_100_2", "strings_100"]
    
    func play(name: String){
        print(name)
        let urlPath = Bundle.main.path(forResource: name, ofType: "mp3")
        print(urlPath)
        let fileURL = URL(fileURLWithPath: urlPath!)
        let somePlayer = playerPool.playerWithURL(url: fileURL)
        somePlayer?.prepareToPlay()
        somePlayer?.play()
        somePlayer?.delegate = self
    }
}
extension Track: AVAudioPlayerDelegate{
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
    }
}
