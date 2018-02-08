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
let TOP_BUFFER:CGFloat = 32
let SIDE_BUFFER:CGFloat = 16
//Buffer between words and rows
let WORD_BUFFER:CGFloat = 10

//TODO: Load this in through a file?
let words = ["could","cloud","bot","bit","ask","a","geek","flame","file","ed","create","like","lap","is","ing","I","her","drive","get","soft","screen","protect","online","meme","to","they","that","tech","space","source","y","write","while"]

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 0, green: 222, blue: 255, alpha: 255)
        
        placeNewWords()
    }

    //Function to place new words on the screen
    func placeNewWords() {
        let furthestScreenDistance = view.frame.size.width - (SIDE_BUFFER * 2)
        
        var row:CGFloat = 0
        var furthestLabelX:CGFloat = 0
        
        for _ in 1...WORDS_ON_SCREEN {
            let word = UILabel()
            word.backgroundColor = UIColor.white
            word.font = UIFont(name: word.font.fontName, size: 22)
            //Get a random word from the list of words
            //TODO: Prevent duplicates? Maybe not as big a deal with lots of words?
            let randNum = Int(arc4random_uniform(UInt32(words.count)))
            word.text = " " + words[randNum] + " " //Spaces are to make the label bigger TODO: better way to do this?
            word.sizeToFit()
            
            //Now lets do the work of placing these in rows
            //Check to see if this label would go off the screen
            if(furthestLabelX + WORD_BUFFER + word.frame.width > furthestScreenDistance) {
                row += 1
                furthestLabelX = 0
            }
            
            //Now that we're on the right row, place the label
            let x = SIDE_BUFFER + WORD_BUFFER + furthestLabelX + (word.frame.width / 2)
            furthestLabelX += word.frame.width + WORD_BUFFER //Update the furthest X
            let y = TOP_BUFFER + row * (WORD_BUFFER + word.frame.height) + (word.frame.height / 2)
            
            word.center = CGPoint(x: x, y: y)
            view.addSubview(word)
            
            //Finally make them draggable
            word.isUserInteractionEnabled = true
            let panGesture = UIPanGestureRecognizer(target: self, action: #selector(dragWord))
            word.addGestureRecognizer(panGesture)
        }
    }
    
    //Function to move the label where the user is dragging
    @objc func dragWord(panGesture:UIPanGestureRecognizer) {
        let word = panGesture.view as! UILabel
        let position = panGesture.location(in: view)
        word.center = position
    }
}

