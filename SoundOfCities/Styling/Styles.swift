//
//  ButtonStyles.swift
//  SoundOfCities
//
//  Created by Geart Otten on 10/12/2018.
//  Copyright © 2018 Geart Otten. All rights reserved.
//

import UIKit
import CoreFoundation

class Styles {
    static func applyStyles() {
        let filledPinkButton = PinkRoundButton.appearance()
        filledPinkButton.setTitleColor(UIColor.white, for: .normal)
        filledPinkButton.cornerRadius = 10
        
        let whiteButtonWithPicture = RoundButtonWithPictore.appearance()
        whiteButtonWithPicture.backgroundColor = .white
        whiteButtonWithPicture.imageEdgeInsets = UIEdgeInsets(top: 12, left: 17, bottom: 12, right: 17)
        whiteButtonWithPicture.cornerRadius = 27
    }
}

class PinkRoundButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()

        let background = CAGradientLayer()
        background.frame = self.bounds
        background.colors = [resonanceOrange.cgColor, resonancePink.cgColor, resonancePurple.cgColor]
        background.cornerRadius = 10
        self.layer.insertSublayer(background, at: 0)
    }
}

class RoundButtonWithPictore: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 5.0)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 4.0
    }
}

class CloseButton: UIButton{}

enum MenuButtonType {
    case navigation
    case tracked
    case camera
    case hike
    case menu
    
    static let images: [MenuButtonType: (UIImage)] =
        [.navigation: UIImage(named: "navigation" )!,
         .tracked: UIImage(named: "tracked")!,
         .camera: UIImage(named: "camera")!,
         .hike: UIImage(named: "hike")!,
         .menu: UIImage(named: "menu")!
    ]
    static let insets: [MenuButtonType: (UIEdgeInsets)] =
        [.navigation: UIEdgeInsets(top: 12, left: 17, bottom: 12, right: 17),
         .menu: UIEdgeInsets(top: 20, left: 15, bottom: 20, right: 15),
         .hike:UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 10),
         .tracked:UIEdgeInsets(top: 12, left: 5, bottom: 12, right: 5)
            
    ]
    
    var buttonImage: UIImage{
        get{
            if let image = MenuButtonType.images[self]{
                return image
            }else{
                return UIImage(named: "placeholder")!
            }
        }
    }
    var edgeInsets: UIEdgeInsets{
        get{
            if let type = MenuButtonType.insets[self]{
                return type
            }
            else{
                return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            }
        }
    }
    var cornerRadius: CGFloat{
        get{
            return 30
        }
    }
}

class MenuButton: UIButton{
    
    init(type: MenuButtonType){
        super.init(frame: CGRect.zero)
        self.setImage(type.buttonImage, for: .normal)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .white
        self.cornerRadius = type.cornerRadius
        self.heightAnchor.constraint(equalToConstant: 60).isActive = true
        self.imageEdgeInsets = type.edgeInsets
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 5.0)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 4.0
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

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
    @objc dynamic var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }
    
    @objc dynamic var borderColor: UIColor? {
        get {
            if let cgColor = layer.borderColor {
                return UIColor(cgColor: cgColor)
            }
            return nil
        }
        set { layer.borderColor = newValue?.cgColor }
    }
    
    @objc dynamic var borderWidth: CGFloat {
        get { return layer.borderWidth }
        set { layer.borderWidth = newValue }
    }
    
    @objc dynamic var titleLabelFont: UIFont! {
        get { return self.titleLabel?.font }
        set { self.titleLabel?.font = newValue }
    }

}
