//
//  AVAudioPlayerPool.swift
//  SoundOfCities
//
//  Created by Geart Otten on 19/11/2018.
//  Copyright © 2018 Geart Otten. All rights reserved.
//
import AVFoundation


class AVAudioPlayerPool {
    var activePlayers : [AVAudioPlayer] = []

    // Given the URL of a sound file, either create or reuse an audio player
    func playerWithURL(url : URL) -> AVAudioPlayer? {
        // Try to find a player that can be reused and is not playing
        let availablePlayers = activePlayers.filter { (player) -> Bool in
            return player.isPlaying == false && player.url == url
        }
        
        // If we found one, return it
        if let playerToUse = availablePlayers.first {
            return playerToUse
        }
        do{
            var newPlayer: AVAudioPlayer? = nil
            try newPlayer = AVAudioPlayer(contentsOf:url)
            activePlayers.append(newPlayer!)
            return newPlayer
        }catch let error{
            print(error)
            fatalError("Newplayer could not be created")
        }
        
    }
}
