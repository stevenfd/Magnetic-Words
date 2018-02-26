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
    private var words: [String]
    
    init(name: String, words: [String]) {
        self.name = name
        self.words = words
    }
    
    convenience init() {
        self.init(name:"Default", words:[])
    }
    
    func getName() -> String {
        return self.name
    }
    
    func getWords() -> [String] {
        return self.words
    }
}
