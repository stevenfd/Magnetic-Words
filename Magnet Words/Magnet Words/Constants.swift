//
//  Constants.swift
//  Book Word Magnets
//
//  Created by Student on 2/26/18.
//  Copyright © 2018 Steven Domitrz. All rights reserved.
//

import UIKit

struct Constants {
    struct PoemSettings {
        static let themeNameKey = "themeNameKey"
        
        static let redValKey = "redValKey"
        static let greenValKey = "greenValKey"
        static let blueValKey = "blueValKey"
        static let imageNameKey = "imageNameKey"
        static let backgroundTypeKey = "backgroundTypeKey"
        static let fontSizeKey = "fontSizeKey"
    }
    
    struct ViewController {
        static let rowsGenerated: CGFloat = 5
        static let bottomAndSideBuffer: CGFloat = 16
        
        struct WordBuffer {
            static let iPhone: CGFloat = 10
            static let iPad: CGFloat = 14
        }
        
        struct WorldHolderHeight {
            static let iPhone: CGFloat = 192
            static let iPad: CGFloat = 222
        }
        
        struct DeleteButtonSize {
            static let width: CGFloat = 34
            static let height: CGFloat = 31
        }
    }
    
    struct FontSizeSlider {
        static let minSize: Int = 24
        struct maxSize {
            static let iPhone: Int = 36
            static let iPad: Int = 50
        }
        struct defaultSize {
            static let iPhone: Int = 28
            static let iPad: Int = 32
        }
    }
    
    struct DefaultBackgroundRGB {
        static let red: Float = 0.73
        static let green: Float = 0.94
        static let blue: Float = 1.0
    }
}
