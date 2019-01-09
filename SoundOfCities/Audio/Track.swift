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
    var playerPool = AVAudioPlayerPool.instance
//    var viewController = MainViewController()
    var isPlaying: Bool?
    var nameOfSong: String?
    var fadeDuration = 6
    
    func play(name: String){
        let urlPath = Bundle.main.path(forResource: name, ofType: "mp3")
        let fileURL = URL(fileURLWithPath: urlPath!)
        let audioPlayer = playerPool.playerWithURL(url: fileURL)
        audioPlayer?.prepareToPlay()
        audioPlayer?.volume = 0
        if playerPool.activePlayers[0].isPlaying{
            audioPlayer?.currentTime = playerPool.activePlayers[0].currentTime
        }
        audioPlayer?.play()
        audioPlayer?.setVolume(1, fadeDuration: TimeInterval(fadeDuration))
        audioPlayer?.numberOfLoops = -1
    }
    func stop(name: String){
        nameOfSong = name
        let activePlayerToStop = findActivePlayer(name: name)
        if activePlayerToStop != nil{
            activePlayerToStop!.setVolume(0, fadeDuration: TimeInterval(fadeDuration))
            Timer.scheduledTimer(timeInterval: TimeInterval(fadeDuration), target: self, selector: #selector(self.stopAfterSeconds), userInfo: nil, repeats: false)
        }
        
        
//        let _ : Timer = Timer.scheduledTimer(timeInterval: fadeDuration, target: self, selector: #selector(self.stopAfterSeconds(name: name)), userInfo: nil, repeats: false)
        
        
    }
    @objc func stopAfterSeconds(){
        let stopPlayer = findActivePlayer(name: nameOfSong!)
        stopPlayer!.currentTime = 0
        stopPlayer!.stop()
        playerPool.setInactive(player: stopPlayer!)
    }
    func findActivePlayer(name: String)->AVAudioPlayer?{
        let urlPath = Bundle.main.path(forResource: name, ofType: "mp3")
        let fileURL = URL(fileURLWithPath: urlPath!)
//        var activePlayerFromName: AVAudioPlayer? = nil
        if let activePlayerFromName =  playerPool.activePlayers.first(where: {$0.url == fileURL}){
            return activePlayerFromName
        }
        return nil
    }
    
}
