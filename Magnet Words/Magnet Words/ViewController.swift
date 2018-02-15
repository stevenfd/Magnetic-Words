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
var wordBuffer:CGFloat = 14

var wordFontSize: CGFloat = 25
var startingHeight: CGFloat = 0

//TODO: Load this in through a file?
let words = ["could","cloud","bot","bit","ask","a","geek","flame","file","ed","create","like","lap","is","ing","I","her","drive","get","soft","screen","protect","online","meme","to","they","that","tech","space","source","y","write","while"]

class ViewController: UIViewController {

    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var deleteIcon: UIBarButtonItem!
    @IBOutlet weak var wordHolder: UIView!
    @IBOutlet weak var downArrow: UIButton!
    @IBOutlet weak var dropdownDeleteButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Base the font size off of the device
        if (UIDevice.current.userInterfaceIdiom == .phone) {
            wordFontSize = 22
            wordBuffer = 10
        } else {
            wordFontSize = 26
            wordBuffer = 14
        }
        
        wordHolder.layer.borderWidth = 1.0
        wordHolder.layer.borderColor = UIColor.black.cgColor
        
        downArrow.layer.borderWidth = 1.0
        downArrow.layer.borderColor = UIColor.black.cgColor
        
        //Same color as launch screen - baf0ff
        view.backgroundColor = UIColor(red: 0.73, green: 0.94, blue: 1.0, alpha: 1.0)
        
        //Figure out the starting height for the words
        startingHeight = view.frame.size.height - BOTTOM_BUFFER - toolBar.frame.size.height
        
        placeNewWords(startingHeight: startingHeight)
    }
    
    //Function to handle "refreshing" the list of words
    @IBAction func newWords(_ sender: Any) {
        removeOldWords(startingHeight: startingHeight)
        placeNewWords(startingHeight: startingHeight)
    }
    
    //Function to add a word when clicking the add button
    /* Got help with this from https://www.simplifiedios.net/ios-dialog-box-with-input/ */
    @IBAction func addCustomWord(_ sender: Any) {
        let addWordAlert = UIAlertController(title: "Custom Word", message: "Enter the word you would like to create", preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "Enter", style: .default, handler: { (_) in
            //Get the input values
            let word = addWordAlert.textFields?[0].text
            
            if word != nil {
                let newLabel = self.createBaseUILabel(text: word!)
                newLabel.center = CGPoint(x: self.view.frame.size.width / 2, y: self.view.frame.size.height / 2)
                newLabel.alpha = 0.0
                self.view.addSubview(newLabel)
                
                UIView.animate(withDuration: 0.4, animations: { newLabel.alpha = 1.0; }, completion: nil)
            }
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in })
        
        addWordAlert.addTextField { (textField) in
            textField.placeholder = "Enter word"
        }
        
        addWordAlert.addAction(confirmAction)
        addWordAlert.addAction(cancelAction)
        
        self.present(addWordAlert, animated: true, completion: nil)
    }
    
    @IBAction func downPress(_ sender: Any) {
        print("Down pressed")
    }
    
    //Private helper functions
    
    //Function to place new words on the screen
    func placeNewWords(startingHeight: CGFloat) {
        let furthestScreenDistanceX = view.frame.size.width - (SIDE_BUFFER * 2)
        
        var row:CGFloat = 1
        var furthestLabelX:CGFloat = 0
        
        while (row <= ROWS_GENERATED) {
            //Get a random word from the list of words
            //TODO: Prevent duplicates? Maybe not as big a deal with lots of words?
            let randNum = Int(arc4random_uniform(UInt32(words.count)))
            
            let word = self.createBaseUILabel(text: words[randNum])
            
            //Now lets do the work of placing these in rows
            //Check to see if this label would go off the screen
            if(furthestLabelX + wordBuffer + word.frame.width > furthestScreenDistanceX) {
                row += 1
                furthestLabelX = 0
                
                //Break out if we're onto too many rows
                if(row == ROWS_GENERATED + 1) {
                    continue
                }
            }
            
            //Now that we're on the right row, place the label
            let x = SIDE_BUFFER + wordBuffer + furthestLabelX + (word.frame.width / 2)
            furthestLabelX += word.frame.width + wordBuffer //Update the furthest X
            let y = startingHeight - (row - 1) * (wordBuffer + word.frame.height) - (word.frame.height / 2)
            
            word.center = CGPoint(x: x, y: y)
            view.addSubview(word)
        }
    }
    
    //Take in a word and create a UILabel with it
    private func createBaseUILabel(text: String) -> UILabel {
        let word = UILabel()
        word.backgroundColor = UIColor.white
        word.font = UIFont(name: word.font.fontName, size: wordFontSize)
        word.text = " " + text + " " //Spaces are to make the label bigger TODO: better way to do this?
        word.sizeToFit()
        
        //Finally make them draggable
        word.isUserInteractionEnabled = true
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(dragWord))
        word.addGestureRecognizer(panGesture)
        
        return word
    }
    
    //Function to move the label where the user is dragging
    @objc private func dragWord(panGesture:UIPanGestureRecognizer) {
        let word = panGesture.view as! UILabel
        let position = panGesture.location(in: view)
        word.center = position
        
        //Calculate the "real" rect for the delete button
        //Which is it's frame + it's container
        let realDeleteRect = CGRect(x: dropdownDeleteButton.frame.minX, y: dropdownDeleteButton.frame.minY + wordHolder.frame.minY, width: dropdownDeleteButton.frame.size.width, height: dropdownDeleteButton.frame.size.height)
        
        //Check to see if the word is within the delete icon
        //Since the UIBarButtons don't have frames, have to estimate
        if(word.frame.maxX > view.frame.size.width * 0.74 && word.frame.maxY > toolBar.frame.minY || word.frame.intersects(realDeleteRect)) {
            word.backgroundColor = UIColor.red
            
            if panGesture.state == UIGestureRecognizerState.ended {
                UIView.animate(withDuration: 0.75, animations: { word.alpha = 0.0; }, completion: { (_: Bool) in word.removeFromSuperview(); })
            }
        } else {
            word.backgroundColor = UIColor.white
        }
        
        print(word.frame.intersects(dropdownDeleteButton.frame))
        print(dropdownDeleteButton.frame)
        print(word.frame)
    }
    
    //Function to remove old words, currently based off where they are positioned
    private func removeOldWords(startingHeight: CGFloat) {
        let word = createBaseUILabel(text: " ")
        
        //Calculate the height at which the words are placed
        let maxHeight = startingHeight - (ROWS_GENERATED - 1) * (wordBuffer + word.frame.height)  - (word.frame.height / 2)
        
        for v in view.subviews{
            if v is UILabel{
                //don't remove it if they moved it
                if v.center.y >= maxHeight {
                    v.removeFromSuperview()
                }
            }
        }
    }
    
}

