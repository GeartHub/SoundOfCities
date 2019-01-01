//
//  HotspotInformationViewController.swift
//  SoundOfCities
//
//  Created by Geart Otten on 28/12/2018.
//  Copyright © 2018 Geart Otten. All rights reserved.
//

import Foundation
import UIKit

class HotspotInformationScreenViewController: UIViewController{
    @IBOutlet weak var hotSpotInformationTextView: UITextView!
    @IBOutlet weak var hotspotNameLabel: UILabel!
    
    var hotspot: Hotspot?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        hotspotNameLabel.text = hotspot?.name
        hotspotNameLabel.adjustsFontSizeToFitWidth = true
        hotSpotInformationTextView.text = hotspot?.information
    }
}
