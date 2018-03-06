//
//  ViewController.swift
//  Magnet Words
//
//  Created by Student on 2/8/18.
//  Copyright © 2018 Steven Domitrz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //MARK - ivars -
    
    //Buffer between words and rows
    var wordBuffer: CGFloat = 14
    
    var startingHeight: CGFloat = 0
    
    var backgroundImage: UIImage?
    
    var poemSettingsBrain: PoemSettingsBrain!

    
    //MARK - Outlets -
    
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var wordHolder: UIView!
    @IBOutlet weak var downArrow: UIButton!
    @IBOutlet weak var themeButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var wordHolderBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var wordHolderHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var deleteButtonWidth: NSLayoutConstraint!
    @IBOutlet weak var deleteButtonHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let baseController = BaseController()
        baseController.setUp()
        
        //Base the font size off of the device
        if UIDevice.current.userInterfaceIdiom == .phone {
            if poemSettingsBrain.fontSize == -1 {
                poemSettingsBrain.fontSize = Constants.FontSizeSlider.defaultSize.iPhone
            }
            wordBuffer = Constants.ViewController.WordBuffer.iPhone
        } else {
            if poemSettingsBrain.fontSize == -1 {
                poemSettingsBrain.fontSize = Constants.FontSizeSlider.defaultSize.iPad
            }
            wordBuffer = Constants.ViewController.WordBuffer.iPad
        }
        
        updateWordHolderHeight()
        
        //Add a border to the wordHolder
        wordHolder.layer.borderWidth = 1.0
        wordHolder.layer.borderColor = UIColor.black.cgColor
        
        //Add border to draggable arrow, and set up its gestures
        downArrow.layer.borderWidth = 1.0
        downArrow.layer.borderColor = UIColor.black.cgColor
        downArrow.isUserInteractionEnabled = true
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(dragWordHolder))
        downArrow.addGestureRecognizer(panGesture)
        
        //Set up background colors, same color as launch screen - baf0ff
        let defaultColor = UIColor(red: CGFloat(Constants.DefaultBackgroundRGB.red), green: CGFloat(Constants.DefaultBackgroundRGB.green), blue: CGFloat(Constants.DefaultBackgroundRGB.blue), alpha: 1.0)
        downArrow.backgroundColor = defaultColor
        
        let selectedColor = UIColor(red: CGFloat(poemSettingsBrain.redVal), green: CGFloat(poemSettingsBrain.greenVal), blue: CGFloat(poemSettingsBrain.blueVal), alpha: 1.0)
        view.backgroundColor = selectedColor
        
        //Figure out the starting height for the words
        startingHeight = wordHolderHeightConstraint.constant - Constants.ViewController.bottomAndSideBuffer
        
        //Load the current theme and place some words
        themeManager.setCurrentTheme(themeName: poemSettingsBrain.themeName)
        themeButton.setTitle(themeManager.getCurrentTheme().getName(), for: .normal)
        placeNewWords(startingHeight: startingHeight)
    }
    
    
    //MARK - Segue Actions -
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showThemeSegue" {
            let themeVC = segue.destination.childViewControllers[0] as! TableViewController
            themeVC.themes = themeManager.getAllThemes()
            themeVC.selectedRow = themeManager.getCurrentThemeIndex()
            //If ipad we need to set the anchor for the popup
            if (UIDevice.current.userInterfaceIdiom == .pad) {
                if((themeVC.popoverPresentationController) != nil) {
                    print("Test this")
                }
                themeVC.popoverPresentationController?.sourceRect = themeButton.bounds
            }
        } else if segue.identifier == "showSettingsSegue" {
            let settingsVC = segue.destination.childViewControllers[0] as! SettingsViewController
            settingsVC.redVal = poemSettingsBrain.redVal
            settingsVC.greenVal = poemSettingsBrain.greenVal
            settingsVC.blueVal = poemSettingsBrain.blueVal
            settingsVC.backgroundIsImage = poemSettingsBrain.isBackgroundAnImage
            settingsVC.fontSize = poemSettingsBrain.fontSize
        }
    }
    
    @IBAction func unwindToMain(segue: UIStoryboardSegue) {
        if(segue.identifier == "SetTheme") {
            let themeVC = segue.source as! TableViewController
            let newIndex = themeVC.selectedRow
            
            themeManager.setCurrentThemeIndex(newIndex: newIndex)
            poemSettingsBrain.themeName = themeManager.getCurrentTheme().getName()
            
            themeButton.setTitle(themeManager.getCurrentTheme().getName(), for: .normal)
            
            newWords(self)
        } else if (segue.identifier == "SaveSettings") {
            let settingsVC = segue.source as! SettingsViewController
            
            poemSettingsBrain?.isBackgroundAnImage = settingsVC.backgroundIsImage
            
            if poemSettingsBrain.isBackgroundAnImage {
                if settingsVC.backgroundImage != nil {
                    backgroundImage = settingsVC.backgroundImage
                    (self.view as! UIImageView).contentMode = .center
                    (self.view as! UIImageView).image = backgroundImage
                }
            } else {
                poemSettingsBrain.redVal = settingsVC.redVal
                poemSettingsBrain.greenVal = settingsVC.greenVal
                poemSettingsBrain.blueVal = settingsVC.blueVal
                (self.view as! UIImageView).image = nil
                self.view.backgroundColor = UIColor(red: CGFloat(poemSettingsBrain.redVal), green: CGFloat(poemSettingsBrain.greenVal), blue: CGFloat(poemSettingsBrain.blueVal), alpha: 1.0)
            }
            
            if poemSettingsBrain.fontSize != settingsVC.fontSize {
                poemSettingsBrain.fontSize = settingsVC.fontSize
                updateWordHolderHeight()
                newWords(self)
                
                for subView in self.view.subviews {
                    if let word = subView as? UILabel{
                        word.font = UIFont(name: word.font.fontName, size: CGFloat(self.poemSettingsBrain.fontSize))
                    }
                }
            }
        }
    }
    
    
    //MARK - Storyboard Action Methods -
    
    //Function to handle "refreshing" the list of words
    @IBAction func newWords(_ sender: Any) {
        removeOldWords(startingHeight: startingHeight)
        placeNewWords(startingHeight: startingHeight)
    }
    
    //Method to share a screenshot
    @IBAction func shareScreenshot(_ sender: Any) {
        //Get the size of the screen we want in the image
        let screenShotSize = CGSize(width: self.view.bounds.width, height: self.view.bounds.height - toolBar.frame.size.height)
        
        //Hide the wordHolder/down arrow/delete button in the screenshot
        wordHolder.isHidden = true
        downArrow.isHidden = true
        deleteButton.isHidden = true
        let image = self.view.takeSnapshot(size: screenShotSize)
        wordHolder.isHidden = false
        downArrow.isHidden = false
        deleteButton.isHidden = false
        
        let textToShare = "I used Book Word Poetry to create this word art!"
        let githubLink = NSURL(string: "https://github.com/stevenfd/Magnetic-Words")
        let objectsToShare: [AnyObject] = [textToShare as AnyObject, githubLink!, image!]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        activityVC.excludedActivityTypes = [UIActivityType.print]
        
        //If ipad we need to specify where it will open
        if (UIDevice.current.userInterfaceIdiom == .pad) {
            activityVC.popoverPresentationController?.barButtonItem = sender as? UIBarButtonItem
        }
        
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
    
    //Function to move the word holder up or down on press of the word holder down arrow
    @IBAction func downArrowPress(_ sender: Any) {
        bringWordHolderToFront()
        
        let bottomBound = getWordHolderBottomBound()
        let topBound = getWordHolderTopBound(bottomBound: bottomBound)
        
        //Decide whether to go up or down based off a certain threshold
        let threshold = bottomBound - ((bottomBound - topBound) * 0.25)
        if downArrow.center.y < threshold {
            moveWordHolderToHeight(height: bottomBound, animationDuration: 0.75)
        } else {
            moveWordHolderToHeight(height: topBound, animationDuration: 0.75)
        }
    }
    
    //MARK - Private Helper Methods - Creation and Deletion of Words
    
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
    
    //Function to remove old words, now we can just remove all from the wordHolder
    private func removeOldWords(startingHeight: CGFloat) {
        for v in wordHolder.subviews{
            if v is UILabel{
                v.removeFromSuperview()
            }
        }
    }
    
    //Take in a word and create a UILabel with it
    private func createBaseUILabel(text: String) -> UILabel {
        let word = UILabel()
        word.backgroundColor = UIColor.white
        word.font = UIFont(name: word.font.fontName, size: CGFloat(poemSettingsBrain.fontSize))
        word.text = " " + text + " " //Spaces are to make the label bigger TODO: better way to do this?
        word.sizeToFit()
        
        //Finally make them draggable
        word.isUserInteractionEnabled = true
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(dragWord))
        let rotateGesure = UIRotationGestureRecognizer(target: self, action: #selector(rotateWord))
        word.addGestureRecognizer(panGesture)
        word.addGestureRecognizer(rotateGesure)
        
        return word
    }
    
    
    //MARK - Gesture Recognizer Methods -
    
    //Method to allow the user to drag the word holder up and down
    @objc private func dragWordHolder(panGesture:UIPanGestureRecognizer) {
        if panGesture.state == .began {
            bringWordHolderToFront()
        }
        
        //Figure out the bounds
        let bottomBound = getWordHolderBottomBound()
        let topBound = getWordHolderTopBound(bottomBound: bottomBound)
        
        var height = panGesture.location(in: view).y
        
        //A little confusing cause top is really less, and bottom is actually higher
        if(height < topBound) {
            height = topBound
        } else if (height > bottomBound) {
            height = bottomBound
        }
        
        moveWordHolderToHeight(height: height, animationDuration: 0)
    }
    
    private func moveWordHolderToHeight(height: CGFloat, animationDuration: Double) {
        let downArrowOriginal = downArrow.center.y
        UIView.animate(withDuration: animationDuration) {
            self.downArrow.center = CGPoint(x: self.wordHolder.center.x, y: height)
            self.wordHolderBottomConstraint.constant += (downArrowOriginal - height)
            self.view.layoutIfNeeded()
        }
    }
    
    //Bring the word holder to the front of the screen, user on enter to drag and tap
    private func bringWordHolderToFront() {
        view.bringSubview(toFront: wordHolder)
        view.bringSubview(toFront: downArrow)
        view.bringSubview(toFront: toolBar)  //Also need to bring the toolbar to the front so its not hidden
    }
    
    //Bottom bound is height of toolbar + half of the downArrow
    private func getWordHolderBottomBound() -> CGFloat {
        return view.frame.height - toolBar.frame.height - (downArrow.frame.height / 2)
    }
    
    //Top bound is bottom + wordHolder
    private func getWordHolderTopBound(bottomBound: CGFloat) -> CGFloat {
        return bottomBound - wordHolderHeightConstraint.constant
    }
    
    //Got help from this from: https://developer.apple.com/documentation/uikit/touches_presses_and_gestures/handling_uikit_gestures/handling_rotation_gestures
    @objc private func rotateWord(rotateGesture: UIRotationGestureRecognizer) {
        // user's two fingers. This creates a more natural looking rotation.
        guard rotateGesture.view != nil else { return }
        
        if rotateGesture.state == .began || rotateGesture.state == .changed {
            rotateGesture.view?.transform = rotateGesture.view!.transform.rotated(by: rotateGesture.rotation)
            rotateGesture.rotation = 0
        }
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
        
        //Figure out the real word location (only have to do this if we're in the subview)
        var wordFrame = word.frame
        if(wordHolder.contains(word)) {
            wordFrame = view.convert(wordFrame, from: wordHolder)
        }
        
        //Check to see if the word is within the delete icon
        if(wordFrame.intersects(deleteButton.frame)) {
            //Don't animate it more than once
            if(word.backgroundColor != UIColor.red) {
                word.backgroundColor = UIColor.red
                
                UIView.animate(withDuration: 0.75, animations: {
                    self.deleteButtonWidth.constant = Constants.ViewController.DeleteButtonSize.width * 2
                    self.deleteButtonHeight.constant = Constants.ViewController.DeleteButtonSize.height * 2
                    self.view.layoutIfNeeded()
                })
            }
            
            if panGesture.state == UIGestureRecognizerState.ended {
                UIView.animate(withDuration: 0.75, animations: {
                    word.alpha = 0.0
                }, completion: {
                    (_: Bool) in word.removeFromSuperview()
                })
            }
        } else {
            //Don't animate it more than once
            if(word.backgroundColor != UIColor.white) {
                word.backgroundColor = UIColor.white
                
                UIView.animate(withDuration: 0.5, animations: {
                    self.deleteButtonWidth.constant = Constants.ViewController.DeleteButtonSize.height
                    self.deleteButtonHeight.constant = Constants.ViewController.DeleteButtonSize.width
                    self.view.layoutIfNeeded()
                })
            }
        }
        
        //If this is the first time they moved it we need to switch views
        if panGesture.state == UIGestureRecognizerState.ended {
            UIView.animate(withDuration: 0.5, animations: {
                self.deleteButton.alpha = 0
            }, completion: { (_: Bool) in
                self.deleteButton.isHidden = true
                self.deleteButtonWidth.constant = Constants.ViewController.DeleteButtonSize.height
                self.deleteButtonHeight.constant = Constants.ViewController.DeleteButtonSize.width
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
    
    private func updateWordHolderHeight() {
        let sampleLabel = createBaseUILabel(text: "Sample Label");
        let height = (sampleLabel.frame.height + wordBuffer) * Constants.ViewController.rowsGenerated + Constants.ViewController.bottomAndSideBuffer * 3
        wordHolderHeightConstraint.constant = height
        
        startingHeight = wordHolderHeightConstraint.constant - Constants.ViewController.bottomAndSideBuffer
    }
    
}

