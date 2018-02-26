//
//  PoemSettings.swift
//  Book Word Magnets
//
//  Created by Student on 2/26/18.
//  Copyright © 2018 Steven Domitrz. All rights reserved.
//

import Foundation

class PoemSettingsModelUserDefaults : PoemSettingsModel {
    let defaults: UserDefaults
    var themeName: String?
    
    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
        
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
