//
//  ViewController.swift
//  Magnet Words
//
//  Created by Student on 2/8/18.
//  Copyright © 2018 Steven Domitrz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //Buffer between words and rows
    var wordBuffer: CGFloat = 14
    
    var wordFontSize: CGFloat = 0
    var startingHeight: CGFloat = 0
    
    var poemSettingsBrain: PoemSettingsBrain?

    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var wordHolder: UIView!
    @IBOutlet weak var downArrow: UIButton!
    @IBOutlet weak var themeButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var wordHolderBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let baseController = BaseController()
        baseController.setUp()
        
        //Base the font size off of the device
        if (UIDevice.current.userInterfaceIdiom == .phone) {
            wordFontSize = Constants.ViewController.WordFontSize.iPhone
            wordBuffer = Constants.ViewController.WordBuffer.iPhone
        } else {
            wordFontSize = Constants.ViewController.WordFontSize.iPad
            wordBuffer = Constants.ViewController.WordBuffer.iPad
        }
        
        wordHolder.layer.borderWidth = 1.0
        wordHolder.layer.borderColor = UIColor.black.cgColor
        
        downArrow.layer.borderWidth = 1.0
        downArrow.layer.borderColor = UIColor.black.cgColor
        downArrow.isUserInteractionEnabled = true
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(dragWordHolder))
        downArrow.addGestureRecognizer(panGesture)
        
        //Same color as launch screen - baf0ff
        view.backgroundColor = UIColor(red: 0.73, green: 0.94, blue: 1.0, alpha: 1.0)
        
        //Figure out the starting height for the words
        startingHeight = wordHolder.frame.size.height - Constants.ViewController.bottomAndSideBuffer
        
        themeManager.setCurrentTheme(themeName: poemSettingsBrain?.getThemeName())
        themeButton.setTitle(themeManager.getCurrentTheme().getName(), for: .normal)
        placeNewWords(startingHeight: startingHeight)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showThemeSegue" {
            print("break here?")
            let themeVC = segue.destination.childViewControllers[0] as! TableViewController
            themeVC.themes = themeManager.getAllThemes()
            themeVC.selectedRow = themeManager.getCurrentThemeIndex()
        }
    }
    
    @IBAction func unwindToMain(segue: UIStoryboardSegue) {
        let themeVC = segue.source as! TableViewController
        let newIndex = themeVC.selectedRow
        
        themeManager.setCurrentThemeIndex(newIndex: newIndex)
        poemSettingsBrain?.setThemeName(themeName: themeManager.getCurrentTheme().getName())
        
        themeButton.setTitle(themeManager.getCurrentTheme().getName(), for: .normal)
        
        newWords(self)
    }
    
    //Function to handle "refreshing" the list of words
    @IBAction func newWords(_ sender: Any) {
        removeOldWords(startingHeight: startingHeight)
        placeNewWords(startingHeight: startingHeight)
    }
    
    @IBAction func shareScreenshot(_ sender: Any) {
        let textToShare = "I used Book Word Poetry to create this word art!"
        let githubLink = NSURL(string: "https://github.com/stevenfd/Magnetic-Words")
        let objectsToShare: [AnyObject] = [textToShare as AnyObject, githubLink!]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        activityVC.excludedActivityTypes = [UIActivityType.print]
        
        self.present(activityVC, animated: true, completion: nil)
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
                
                UIView.animate(withDuration: 0.4, animations: {
                    newLabel.alpha = 1.0
                }, completion: nil)
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
    
    //Private helper functions
    
    //Function to place new words on the screen
    private func placeNewWords(startingHeight: CGFloat) {
        let furthestScreenDistanceX = view.frame.size.width - (Constants.ViewController.bottomAndSideBuffer * 2)
        
        var row:CGFloat = 1
        var furthestLabelX:CGFloat = 0
        
        while (row <= Constants.ViewController.rowsGenerated) {
            //Get a random word from the list of words
            //TODO: Prevent duplicates? Maybe not as big a deal with lots of words?
            let currentWords = themeManager.getCurrentTheme().getWords()
            let randNum = Int(arc4random_uniform(UInt32(currentWords.count)))
            
            let word = self.createBaseUILabel(text: currentWords[randNum])
            
            //Now lets do the work of placing these in rows
            //Check to see if this label would go off the screen
            if(furthestLabelX + wordBuffer + word.frame.width > furthestScreenDistanceX) {
                row += 1
                furthestLabelX = 0
                
                //Break out if we're onto too many rows
                if(row == Constants.ViewController.rowsGenerated + 1) {
                    continue
                }
            }
            
            //Now that we're on the right row, place the label
            let x = Constants.ViewController.bottomAndSideBuffer + wordBuffer + furthestLabelX + (word.frame.width / 2)
            furthestLabelX += word.frame.width + wordBuffer //Update the furthest X
            let y = startingHeight - (row - 1) * (wordBuffer + word.frame.height) - (word.frame.height / 2)
            
            word.center = CGPoint(x: x, y: y)
            wordHolder.addSubview(word)
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
    
    //Method to allow the user to drag the word holder up and down
    @objc private func dragWordHolder(panGesture:UIPanGestureRecognizer) {
        //Whenever the word holder is dragged, bring it to the front
        view.bringSubview(toFront: wordHolder)
        view.bringSubview(toFront: downArrow)
        view.bringSubview(toFront: toolBar)  //Also need to bring the toolbar to the front so its not hidden
        
        //Figure out the bounds
        //Bottom bound is height of toolbar + half of the downArrow
        let bottomBound = view.frame.height - toolBar.frame.height - (downArrow.frame.height / 2)
        
        //Top bound is bottom + wordHolder
        let topBound = bottomBound - wordHolder.frame.height
        
        var height = panGesture.location(in: view).y
        
        //A little confusing cause top is really less, and bottom is actually higher
        if(height < topBound) {
            height = topBound
        } else if (height > bottomBound) {
            height = bottomBound
        }
        
        let downArrowOriginal = downArrow.center.y
        downArrow.center = CGPoint(x: wordHolder.center.x, y: height)
        wordHolderBottomConstraint.constant += (downArrowOriginal - height)
    }
    
    //Function to move the label where the user is dragging
    @objc private func dragWord(panGesture:UIPanGestureRecognizer) {
        let word = panGesture.view as! UILabel
        
        view.bringSubview(toFront: word)
        
        if(panGesture.state == UIGestureRecognizerState.began) {
            deleteButton.isHidden = false
            UIView.animate(withDuration: 0.5, animations: {
                self.deleteButton.alpha = 1.0
            })
        }
        
        let position = panGesture.location(in: word.superview)
        word.center = position
        
        //Check to see if the word is within the delete icon
        if(word.frame.intersects(deleteButton.frame)) {
            word.backgroundColor = UIColor.red
            
            if panGesture.state == UIGestureRecognizerState.ended {
                UIView.animate(withDuration: 0.75, animations: {
                    word.alpha = 0.0
                }, completion: {
                    (_: Bool) in word.removeFromSuperview()
                })
            }
        } else {
            word.backgroundColor = UIColor.white
        }
        
        //If this is the first time they moved it we need to switch views
        if panGesture.state == UIGestureRecognizerState.ended {
            UIView.animate(withDuration: 0.5, animations: {
                self.deleteButton.alpha = 0
            }, completion: { (_: Bool) in
                self.deleteButton.isHidden = true
            })
            
            if wordHolder.subviews.contains(word) {
                word.removeFromSuperview()
                
                //Add the difference in height so it reappears
                let difference = wordHolder.frame.minY
                word.frame = CGRect(x: word.frame.minX, y: word.frame.minY + difference, width: word.frame.width, height: word.frame.height)
                view.addSubview(word)
            }
        }
    }
    
    //Function to remove old words, now we can just remove all from the wordHolder
    private func removeOldWords(startingHeight: CGFloat) {
        for v in wordHolder.subviews{
            if v is UILabel{
                v.removeFromSuperview()
            }
        }
    }
    
}

