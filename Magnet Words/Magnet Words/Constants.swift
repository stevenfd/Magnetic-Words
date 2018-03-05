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
        static let fontNameKey = "fontNameKey"
        static let backgroundTypeKey = "backgroundTypeKey"
    }
    
    struct ViewController {
        static let rowsGenerated: CGFloat = 4
        static let bottomAndSideBuffer: CGFloat = 16
        
        struct WordFontSize {
            static let iPhone: CGFloat = 24
            static let iPad: CGFloat = 28
        }
        
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
    
    struct FontNames {
        static let GameOfThrones = "Game of Thrones"
        static let HarryPotter = "Harry P"
        static let Inheritance = "Inheritance Font"
    }
    
    struct DefaultBackgroundRGB {
        static let red: Float = 0.73
        static let green: Float = 0.94
        static let blue: Float = 1.0
    }
}
