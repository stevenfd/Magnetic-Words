//
//  ThemeManager.swift
//  Book Word Magnets
//
//  Created by Student on 2/19/18.
//  Copyright © 2018 Steven Domitrz. All rights reserved.
//

import Foundation

public class ThemeManager {
    private var currentThemeIndex: Int = 0
    private var themes: [Theme]
    
    init(currentThemeIndex: Int, themes: [Theme]) {
        self.currentThemeIndex = currentThemeIndex
        self.themes = themes
    }
    
    convenience init() {
        self.init(currentThemeIndex: -1, themes: [])
    }
    
    func getCurrentThemeIndex() -> Int {
        return currentThemeIndex
    }
    
    func setCurrentThemeIndex(newIndex: Int) {
        if(validateNewIndex(newVal: newIndex)) {
            currentThemeIndex = newIndex
        }
    }
    
    func getCurrentTheme() -> Theme {
        if(currentThemeIndex >= 0) {
            return themes[currentThemeIndex]
        }
        return Theme()
    }
    
    func getAllThemes() -> [Theme] {
        return themes
    }
    
    private func validateNewIndex(newVal: Int) -> Bool {
        return (newVal >= 0 && newVal < themes.count)
    }
}
