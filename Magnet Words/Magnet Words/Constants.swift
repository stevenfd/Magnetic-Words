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
    }
    
    struct ViewController {
        static let rowsGenerated: CGFloat = 4
        static let bottomAndSideBuffer: CGFloat = 16
        
        struct WordFontSize {
            static let iPhone: CGFloat = 22
            static let iPad: CGFloat = 26
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
}
