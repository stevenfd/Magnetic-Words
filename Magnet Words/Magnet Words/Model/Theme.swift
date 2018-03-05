//
//  Theme.swift
//  Book Word Magnets
//
//  Created by Student on 2/19/18.
//  Copyright © 2018 Steven Domitrz. All rights reserved.
//

import Foundation

//Class to hold all of the data for a Theme (set of words)
public class Theme {
    private var name: String
    private var fontName: String?
    private var words: [String]
    
    init(name: String, words: [String], fontName: String? = nil) {
        self.name = name
        self.words = words
        self.fontName = fontName
    }
    
    convenience init() {
        self.init(name:"Default", words:[])
    }
    
    func getName() -> String {
        return self.name
    }
    
    func getFontName() -> String? {
        return self.fontName
    }
    
    func getWords() -> [String] {
        return self.words
    }
}
