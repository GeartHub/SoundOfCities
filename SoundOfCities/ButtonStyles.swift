//
//  ButtonStyles.swift
//  SoundOfCities
//
//  Created by Geart Otten on 10/12/2018.
//  Copyright © 2018 Geart Otten. All rights reserved.
//

import UIKit

class ButtonStyles {
    static func applyButtonStyles() {
        let button = UIButton.appearance()
        button.titleLabelFont = UIFont(name: "AvenirNext-DemiBold", size: 18.0)
        button.cornerRadius = 12
        button.titleLabel?.numberOfLines = 1
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        
        let filledPinkButton = PinkRoundButton.appearance()
        filledPinkButton.setTitleColor(UIColor.white, for: .normal)
        filledPinkButton.backgroundColor = resonancePink
        filledPinkButton.cornerRadius = 10
        
        let closeButton = CloseButton.appearance()
        closeButton.setTitleColor(UIColor.white, for: .normal)
        closeButton.backgroundColor = resonancePink
        closeButton.cornerRadius = 15
        
        //        roundButton.setTitleColor(repressBlue, for: .disabled)
        //        roundButton.setBackgroundImage(imageFromColor(UIColor.gray), for: .disabled)
    }
}

class PinkRoundButton: UIButton {}

class WhiteButton: UIButton {}

class RoundButton: UIButton{}

class CloseButton: UIButton{}

// WARNING: Breaks corner radius, no fix yet
// Needs to be used to set background color for buttons with states
func imageFromColor(_ colour: UIColor) -> UIImage {
    let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
    UIGraphicsBeginImageContext(rect.size)
    let context = UIGraphicsGetCurrentContext()
    context!.setFillColor(colour.cgColor)
    context!.fill(rect)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image!
}

extension UIButton {
    @objc dynamic override var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }
    
    @objc dynamic override var borderColor: UIColor? {
        get {
            if let cgColor = layer.borderColor {
                return UIColor(cgColor: cgColor)
            }
            return nil
        }
        set { layer.borderColor = newValue?.cgColor }
    }
    
    @objc dynamic override var borderWidth: CGFloat {
        get { return layer.borderWidth }
        set { layer.borderWidth = newValue }
    }
    
    @objc dynamic var titleLabelFont: UIFont! {
        get { return self.titleLabel?.font }
        set { self.titleLabel?.font = newValue }
    }
}

