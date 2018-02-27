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
    var redVal: CGFloat
    var greenVal: CGFloat
    var blueVal: CGFloat
    
    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
        self.redVal = 0
        self.greenVal = 0
        self.blueVal = 0
        
        load()
    }
    
    func save() {
        defaults.set(themeName, forKey: Constants.PoemSettings.themeNameKey)
    }
    
    func load() {
        if let themeName = defaults.value(forKey: Constants.PoemSettings.themeNameKey) as? String {
            self.themeName = themeName
        }
    }
    
    
}
