//
//  ThemeManagerTests.swift
//  Book Word MagnetsTests
//
//  Created by Student on 2/19/18.
//  Copyright © 2018 Steven Domitrz. All rights reserved.
//

import XCTest

class ThemeManagerTests: XCTestCase {
    
    var manager: ThemeManager = ThemeManager()
    var themes: [Theme] = []
    
    override func setUp() {
        super.setUp()
        themes.append(Theme(name: "Harry Potter", words: ["Harry", "Hagrid", "Ron"]))
        themes.append(Theme(name: "Inheritance", words: ["Eragon", "Eldest", "Brisingr"]))
        themes.append(Theme(name: "Game of Thrones", words: ["Jon Snow", "Tyrian", "Taergaryn"]))
        
        manager = ThemeManager(currentThemeIndex: 0, themes: themes)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDefaultInit() {
        manager = ThemeManager()
        
        XCTAssertEqual(manager.getCurrentThemeIndex(), -1)
        XCTAssertEqual(manager.getAllThemes().count, 0)
    }
    
    func testInit() {
        XCTAssertEqual(manager.getCurrentThemeIndex(), 0)
        XCTAssertEqual(manager.getAllThemes().count, 3)
    }
    
    func testGetCurrentTheme() {
        XCTAssertEqual(manager.getCurrentTheme().getName(), themes[0].getName())
        XCTAssertEqual(manager.getCurrentTheme().getWords(), themes[0].getWords())
    }
    
    func testGetCurrentThemeBadIndex() {
        manager = ThemeManager()
        
        XCTAssertEqual(manager.getCurrentTheme().getName(), Theme().getName())
        XCTAssertEqual(manager.getCurrentTheme().getWords(), Theme().getWords())
    }
    
    func testSetCurrentThemeIndexAboveThemeCount() {
        manager.setCurrentThemeIndex(newIndex: 2)
        manager.setCurrentThemeIndex(newIndex: 5)
        
        XCTAssertEqual(manager.getCurrentThemeIndex(), 2)
    }
    
    func testSetCurrentThemeIndexBelowZero() {
        manager.setCurrentThemeIndex(newIndex: -10)
        
        XCTAssertEqual(manager.getCurrentThemeIndex(), 0)
    }
    
    func testSetCurrentThemeIndexValid() {
        manager.setCurrentThemeIndex(newIndex: 1)
        
        XCTAssertEqual(manager.getCurrentThemeIndex(), 1)
    }
}


