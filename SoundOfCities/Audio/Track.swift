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
    var isPlaying: Bool?
    
    func play(name: String){
        // check if something is playing
        // wait till other is done
    
        let urlPath = Bundle.main.path(forResource: name, ofType: "mp3")
        print("urlPath: ", urlPath)
        let fileURL = URL(fileURLWithPath: urlPath!)
        print("fileURL: ", fileURL)
        let somePlayer = playerPool.playerWithURL(url: fileURL)
        somePlayer?.prepareToPlay()
        somePlayer?.volume = 0
        print(playerPool.activePlayers[0].isPlaying, " ", playerPool.activePlayers[0].currentTime)
        if playerPool.activePlayers[0].isPlaying{
            somePlayer?.currentTime = playerPool.activePlayers[0].currentTime
        }
        somePlayer?.play()
        somePlayer?.setVolume(1, fadeDuration: 6)
        somePlayer?.numberOfLoops = -1
    }
    func stop(name: String){
        let urlPath = Bundle.main.path(forResource: name, ofType: "mp3")
        let fileURL = URL(fileURLWithPath: urlPath!)
        let theActivePlayerToStop = playerPool.activePlayers.first(where: {$0.url == fileURL})
        theActivePlayerToStop?.setVolume(0, fadeDuration: 10)
        theActivePlayerToStop?.currentTime = 0
        if theActivePlayerToStop?.volume == 0{
            theActivePlayerToStop?.stop()
        }
    }
}
