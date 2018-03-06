//
//  PoemSettings.swift
//  Book Word Magnets
//
//  Created by Student on 2/26/18.
//  Copyright © 2018 Steven Domitrz. All rights reserved.
//

import UIKit

class PoemSettingsModelUserDefaults : PoemSettingsModel {
    let defaults: UserDefaults
    var themeName: String?
    
    var redVal: Float
    var greenVal: Float
    var blueVal: Float
    var imageName: String?
    var fontSize: Int
    var isBackgroundAnImage: Bool
    
    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
        self.themeName = nil
        
        self.redVal = Constants.DefaultBackgroundRGB.red
        self.greenVal = Constants.DefaultBackgroundRGB.green
        self.blueVal = Constants.DefaultBackgroundRGB.blue
        self.isBackgroundAnImage = false
        self.imageName = nil
        self.fontSize = -1
        
        load()
    }
    
    func save() {
        defaults.set(themeName, forKey: Constants.PoemSettings.themeNameKey)
        defaults.set(redVal, forKey: Constants.PoemSettings.redValKey)
        defaults.set(blueVal, forKey: Constants.PoemSettings.blueValKey)
        defaults.set(greenVal, forKey: Constants.PoemSettings.greenValKey)
        defaults.set(imageName, forKey: Constants.PoemSettings.imageNameKey)
        defaults.set(isBackgroundAnImage, forKey: Constants.PoemSettings.backgroundTypeKey)
        defaults.set(fontSize, forKey: Constants.PoemSettings.fontSizeKey)
    }
    
    func load() {
        if let themeName = defaults.value(forKey: Constants.PoemSettings.themeNameKey) as? String {
            self.themeName = themeName
        }
        
        if let redVal = defaults.value(forKey: Constants.PoemSettings.redValKey) as? Float {
            self.redVal = redVal
        }
        if let greenVal = defaults.value(forKey: Constants.PoemSettings.greenValKey) as? Float {
            self.greenVal = greenVal
        }
        if let blueVal = defaults.value(forKey: Constants.PoemSettings.blueValKey) as? Float {
            self.blueVal = blueVal
        }
        if let imageName = defaults.value(forKey: Constants.PoemSettings.imageNameKey) as? String {
            self.imageName = imageName
        }
        if let isBackgroundAnImage = defaults.value(forKey: Constants.PoemSettings.backgroundTypeKey) as? Bool {
            self.isBackgroundAnImage = isBackgroundAnImage
        }
        if let fontSize = defaults.value(forKey: Constants.PoemSettings.fontSizeKey) as? Int {
            self.fontSize = fontSize
        }
    }
    
    
}
