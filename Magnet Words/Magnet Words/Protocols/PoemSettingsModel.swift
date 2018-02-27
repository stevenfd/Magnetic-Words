//
//  PoemSettingsProtocol.swift
//  Book Word Magnets
//
//  Created by Student on 2/26/18.
//  Copyright © 2018 Steven Domitrz. All rights reserved.
//

import Foundation

protocol PoemSettingsModel {
    var themeName: String? {get set}
    
    var redVal: Float {get set}
    var greenVal: Float {get set}
    var blueVal: Float {get set}
    var imageName: String? {get set}
    
    func save()
    func load()
}
