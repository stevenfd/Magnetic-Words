//
//  BaseController.swift
//  Book Word Magnets
//
//  Created by Student on 2/19/18.
//  Copyright © 2018 Steven Domitrz. All rights reserved.
//

import Foundation

var themeManager = ThemeManager()

class BaseController {
    
    public func setUp() {
        //Create some base themes
        var themes: [Theme] = []
        var words = ["could","cloud","bot","bit","ask","a","geek","flame","file","ed","create","like","lap","is","ing","I","her","drive","get","soft","screen","protect","online","meme","to","they","that","tech","space","source","y","write","while"]
        themes.append(Theme(name: "Plain Words", words: words))
        
        words = ["could","cloud","bot","bit","ask","a","geek","flame","file","ed","create","like","lap","is","ing","I","her","drive","get","soft","screen","protect","online","meme","to","they","that","tech","space","source","y","write","while"]
        themes.append(Theme(name: "Harry Potter", words: words))
        
        words = ["could","cloud","bot","bit","ask","a","geek","flame","file","ed","create","like","lap","is","ing","I","her","drive","get","soft","screen","protect","online","meme","to","they","that","tech","space","source","y","write","while"]
        themes.append(Theme(name: "Inheritance", words: words))
        
        words = ["could","cloud","bot","bit","ask","a","geek","flame","file","ed","create","like","lap","is","ing","I","her","drive","get","soft","screen","protect","online","meme","to","they","that","tech","space","source","y","write","while"]
        themes.append(Theme(name: "Game of Thrones", words: words))
        
        themeManager = ThemeManager(currentThemeIndex: 0, themes: themes)
    }
}
