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
    
    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
        self.themeName = nil
        
        self.redVal = 0
        self.greenVal = 0
        self.blueVal = 0
        self.imageName = nil
        
        load()
    }
    
    func save() {
        defaults.set(themeName, forKey: Constants.PoemSettings.themeNameKey)
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
    }
    
    
}
