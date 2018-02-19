//
//  ThemeTests.swift
//  Book Word MagnetsTests
//
//  Created by Student on 2/19/18.
//  Copyright © 2018 Steven Domitrz. All rights reserved.
//

import XCTest

class ThemeTests: XCTestCase {
    
    var theme = Theme()
    
    func testDefaultInit() {
        theme = Theme()
        
        XCTAssertEqual(theme.getName(), "Default")
        XCTAssertEqual(theme.getWords(), [])
    }
    
    func testInit() {
        theme = Theme(name: "Marvel", words: ["IronMan", "Hulk", "AntMan"])
        
        XCTAssertEqual(theme.getName(), "Marvel")
        let words = theme.getWords()
        XCTAssertEqual(words[0], "IronMan")
        XCTAssertEqual(words[1], "Hulk")
        XCTAssertEqual(words[2], "AntMan")
    }
    
}
