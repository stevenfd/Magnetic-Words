//
//  ViewController.swift
//  Magnet Words
//
//  Created by Student on 2/8/18.
//  Copyright © 2018 Steven Domitrz. All rights reserved.
//

import UIKit

let ROWS_GENERATED: CGFloat = 4

//Buffer on the side of the application
let BOTTOM_BUFFER:CGFloat = 16
let SIDE_BUFFER:CGFloat = 16
//Buffer between words and rows
let WORD_BUFFER:CGFloat = 14

//TODO: Load this in through a file?
let words = ["could","cloud","bot","bit","ask","a","geek","flame","file","ed","create","like","lap","is","ing","I","her","drive","get","soft","screen","protect","online","meme","to","they","that","tech","space","source","y","write","while"]

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Same color as launch screen - baf0ff
        view.backgroundColor = UIColor(red: 0.73, green: 0.94, blue: 1.0, alpha: 1.0)
        
        placeNewWords()
    }

    //Function to place new words on the screen
    func placeNewWords() {
        let furthestScreenDistanceX = view.frame.size.width - (SIDE_BUFFER * 2)
        
        var row:CGFloat = 1
        var furthestLabelX:CGFloat = 0
        
        while (row <= ROWS_GENERATED) {
            let word = UILabel()
            word.backgroundColor = UIColor.white
            word.font = UIFont(name: word.font.fontName, size: 25)
            //Get a random word from the list of words
            //TODO: Prevent duplicates? Maybe not as big a deal with lots of words?
            let randNum = Int(arc4random_uniform(UInt32(words.count)))
            word.text = " " + words[randNum] + " " //Spaces are to make the label bigger TODO: better way to do this?
            word.sizeToFit()
            
            //Now lets do the work of placing these in rows
            //Check to see if this label would go off the screen
            if(furthestLabelX + WORD_BUFFER + word.frame.width > furthestScreenDistanceX) {
                row += 1
                furthestLabelX = 0
                
                //Break out if we're onto too many rows
                if(row == ROWS_GENERATED + 1) {
                    continue
                }
            }
            
            //Now that we're on the right row, place the label
            let x = SIDE_BUFFER + WORD_BUFFER + furthestLabelX + (word.frame.width / 2)
            furthestLabelX += word.frame.width + WORD_BUFFER //Update the furthest X
            let y = view.frame.size.height - BOTTOM_BUFFER - (row - 1) * (WORD_BUFFER + word.frame.height) - (word.frame.height / 2)
            
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

