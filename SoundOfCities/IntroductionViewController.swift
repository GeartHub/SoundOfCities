//
//  IntroductionViewController.swift
//  SoundOfCities
//
//  Created by Geart Otten on 08/11/2018.
//  Copyright © 2018 Geart Otten. All rights reserved.
//

import UIKit
import AVFoundation
import CoreLocation
import Foundation
import ZIPFoundation

class IntroductionViewController: UIViewController {
    
    @IBOutlet weak var nextButton: UIButton!
    var track = Track()
    var playerPool = AVAudioPlayerPool.instance
    var package = Package()
    var zoneManager = ZoneManager.instance
    
    
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareSongsAndSession()
//        package.makeTestPackage()
        nextButton.imageEdgeInsets = UIEdgeInsets(top: 10,left: 5,bottom: 10,right: 5)
        NotificationCenter.default.addObserver(self, selector: #selector(goToMap), name: .finishedPackageDownload, object: nil)
    }
    
    @IBAction func downloadPackage(_ sender: Any) {
        package.download()
        
    }
    @objc func waitSeconds(){
        let _ = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(IntroductionViewController.goToMap), userInfo: nil, repeats: false)
    }
    @objc func goToMap(){
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "test", sender: nil)
        }
    }
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
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
