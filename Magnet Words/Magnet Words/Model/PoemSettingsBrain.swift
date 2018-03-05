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
    
    var themeName: String? {
        get {
            return dataModel.themeName
        }
        set {
            dataModel.themeName = newValue
            dataModel.save()
        }
    }
    
    var redVal: Float {
        get {
            return dataModel.redVal
        }
        set {
            dataModel.redVal = newValue
            dataModel.save()
        }
    }
    var greenVal: Float {
        get {
            return dataModel.greenVal
        }
        set {
            dataModel.greenVal = newValue
            dataModel.save()
        }
    }
    var blueVal: Float {
        get {
            return dataModel.blueVal
        }
        set {
            dataModel.blueVal = newValue
            dataModel.save()
        }
    }
    var imageName: String? {
        get {
            return dataModel.imageName
        }
        set {
            dataModel.imageName = newValue
            dataModel.save()
        }
    }
    var fontName: String? {
        get {
            return dataModel.fontName
        }
        set {
            dataModel.fontName = newValue
            dataModel.save()
        }
    }
    var isBackgroundAnImage: Bool {
        get {
            return dataModel.isBackgroundAnImage
        }
        set {
            dataModel.isBackgroundAnImage = newValue
            dataModel.save()
        }
    }
    
    init(dataModel: PoemSettingsModel = PoemSettingsModelUserDefaults()) {
        self.dataModel = dataModel
    }
    
}
