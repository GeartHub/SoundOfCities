//
//  LaunchScreenViewController.swift
//  SoundOfCities
//
//  Created by Geart Otten on 19/11/2018.
//  Copyright © 2018 Geart Otten. All rights reserved.
//

import Foundation
import UIKit

class LaunchScreenViewController: UIViewController{
    
    @IBOutlet weak var popImage: UIImageView!
    let translate = CGAffineTransform(translationX: 0, y: 0)
    var scale = CGAffineTransform(scaleX: 1.3 , y: 1.3)
    let minScale = CGAffineTransform(scaleX: 1, y: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        plop()
    }
    func plop(){
        UIView.animate(withDuration: 0.5, animations: {
            self.popImage.transform = self.translate.concatenating(self.scale)
        }, completion: {(value: Bool) in
            UIView.animate(withDuration: 0.5, animations: {
                self.popImage.transform = self.translate.concatenating(self.minScale)
            }, completion: {(value: Bool) in
                self.performSegue(withIdentifier: "AfterLaunchSegue", sender: nil)
            })
        })
    }
}
