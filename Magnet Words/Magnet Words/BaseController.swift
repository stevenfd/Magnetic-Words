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
        
        words = ["Harry","Hargid","Ron","Voldemort","wand","magic","Hogwarts","flame","goblet","of","fire","owl","dark arts","alchemy","newt","muggle","wizard","Azkaban","stone","snitch","quidditch","polyjuice","patronus","house","Gryffindor","Hufflepuff","Ravenclaw","Slytherin","student","sort","hat","s","ing"]
        themes.append(Theme(name: "Harry Potter", words: words))
        
        words = ["Eragon","dragon","fire","egg","dragon","rider","sword","bow","magic","elf","dwarf","human","s","siege","battle","castle","army","Durza","Brom","Brisingr","Arya","Oromis","spell","deyja","flauga","king","rider","Urgal","village","town","breathing","magic","explosion"]
        themes.append(Theme(name: "Inheritance", words: words))
        
        words = ["Jon","Snow","Targaryen","Dothraki","direwolf","crow","north","wall","Faceless Men","grayscale","hand","throne","king","queen","khaleesi","maester","watch","night","winter","coming","Quarth","Unsullied","sellsword","wildlings","Yunkai","slave","fire","Lannister","Stark","Tarrwell","Dragonstone","King's Landing","Winterfell"]
        themes.append(Theme(name: "Game of Thrones", words: words))
        
        themeManager = ThemeManager(currentThemeIndex: 0, themes: themes)
    }
}
