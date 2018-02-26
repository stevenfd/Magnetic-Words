//
//  PoemSettingsBrain.swift
//  Book Word Magnets
//
//  Created by Student on 2/26/18.
//  Copyright © 2018 Steven Domitrz. All rights reserved.
//

import Foundation

class PoemSettingsBrain {
    private var dataModel: PoemSettingsModel
    
    private var themeName: String {
        get {
            return dataModel.themeName
        }
        set {
            dataModel.themeName = newValue
        }
    }
    
    init(dataModel: PoemSettingsModel) {
        self.dataModel = dataModel
    }
    
    func setThemeName(themeName: String) {
        self.themeName = themeName
        dataModel.save()
    }
}
