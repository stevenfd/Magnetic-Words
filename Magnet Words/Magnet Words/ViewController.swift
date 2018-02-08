//
//  ViewController.swift
//  Magnet Words
//
//  Created by Student on 2/8/18.
//  Copyright © 2018 Steven Domitrz. All rights reserved.
//

import UIKit

let WORDS_ON_SCREEN = 20

//Buffer on the side of the application
let SIDE_BUFFER = 16
//Buffer between words and rows
let WORD_BUFFER = 8

//TODO: Load this in through a file?
let words = ["could","cloud","bot","bit","ask","a","geek","flame","file","ed","create","like","lap","is","ing","I","her","drive","get","soft","screen","protect","online","meme","to","they","that","tech","space","source","y","write","while"]

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.blue
        
    }

    //Function to place new words on the screen
    func placeNewWords() {
        var row = 0
        var furthestLabel = 0
        
        for index in 1...WORDS_ON_SCREEN {
            let word = UILabel()
            word.backgroundColor = UIColor.white
            //Get a random word from the list of words
            //TODO: Prevent duplicates? Maybe not as big a deal with lots of words?
            let randNum = Int(arc4random_uniform(UInt32(words.count)))
            word.text = words[randNum]
            word.sizeToFit()
            
            //Now lets do the work of placing these in rows
            
        }
    }
}

