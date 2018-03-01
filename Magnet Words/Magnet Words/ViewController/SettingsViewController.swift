//
//  SettingsViewController.swift
//  Book Word Magnets
//
//  Created by Student on 2/27/18.
//  Copyright © 2018 Steven Domitrz. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var backgroundImage: UIImage?
    var redVal: Float = 0
    var greenVal: Float = 0
    var blueVal: Float = 0
    
    var backgroundIsImage: Bool = false
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var redText: UITextField!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var greenText: UITextField!
    @IBOutlet weak var blueSlider: UISlider!
    @IBOutlet weak var blueText: UITextField!
    @IBOutlet weak var colorDisplay: UIView!
    @IBOutlet weak var imageSwitch: UISwitch!
    @IBOutlet weak var colorSwitch: UISwitch!
    @IBOutlet weak var selectImageButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorDisplay.layer.borderWidth = 1.0
        colorDisplay.layer.borderColor = UIColor.black.cgColor
        
        updateTextColorValue()
        updateSliderColorValue()
        updateColorDisplayValue()
        
        updateBackgroundUI()
    }
    
    //Method to allow the user to set a background image
    @IBAction func setBackgroundImage(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func changeBackgroundType(_ sender: Any) {
        if sender as? UISwitch == imageSwitch {
            backgroundIsImage = imageSwitch.isOn
        } else {
            backgroundIsImage = !colorSwitch.isOn
        }
        
        updateBackgroundUI()
    }
    
    private func updateBackgroundUI() {
        imageSwitch.setOn(backgroundIsImage, animated: true)
        colorSwitch.setOn(!backgroundIsImage, animated: true)
        
        selectImageButton.isEnabled = backgroundIsImage
        redText.isEnabled = !backgroundIsImage
        redSlider.isEnabled = !backgroundIsImage
        greenText.isEnabled = !backgroundIsImage
        greenSlider.isEnabled = !backgroundIsImage
        blueText.isEnabled = !backgroundIsImage
        blueSlider.isEnabled = !backgroundIsImage
    }
    
    
    //Actions
    @IBAction func actionColorChangeSlider(_ sender: Any) {
        redVal = redSlider.value
        greenVal = greenSlider.value
        blueVal = blueSlider.value
        
        updateTextColorValue()
        updateColorDisplayValue()
    }
    
    @IBAction func actionColorChangeTextField(_ sender: Any) {
        var red = Int(redText.text!)
        var green = Int(greenText.text!)
        var blue = Int(blueText.text!)
        
        red = validateRGBValue(val: red!)
        green = validateRGBValue(val: green!)
        blue = validateRGBValue(val: blue!)
        
        if red != nil {
            redVal = intRBGtoFloat(val: red!)
        } else {
            inValidRBGValuePopup()
        }
        if green != nil {
            greenVal = intRBGtoFloat(val: green!)
        } else {
            inValidRBGValuePopup()
        }
        if blue != nil {
            blueVal = intRBGtoFloat(val: blue!)
        } else {
            inValidRBGValuePopup()
        }
        
        updateTextColorValue()
        updateSliderColorValue()
        updateColorDisplayValue()
    }
    
    private func validateRGBValue(val: Int?) -> Int? {
        if val != nil {
            var newVal: Int? = val
            if(newVal! > 255) {
                newVal = nil
            } else if newVal! < 0 {
                newVal = nil
            }
            return newVal
        } else {
            return val
        }
    }
    
    func inValidRBGValuePopup() {
        let invalidValueAlert = UIAlertController(title: "Invalid Value", message: "RGB values entered must be between 0 and 255", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: { (_) in })
        
        invalidValueAlert.addAction(okAction)
        
        self.present(invalidValueAlert, animated: true, completion: nil)
    }
    
    private func intRBGtoFloat(val: Int) -> Float {
        return Float(val) / 255
    }
    
    //Functions
    func updateTextColorValue() {
        redText.text = String(format: "%0.0f", redVal * 255)
        greenText.text = String(format: "%0.0f", greenVal * 255)
        blueText.text = String(format: "%0.0f", blueVal * 255)
    }
    
    func updateSliderColorValue() {
        redSlider.value = redVal
        greenSlider.value = greenVal
        blueSlider.value = blueVal
    }
    
    func updateColorDisplayValue() {
        colorDisplay.backgroundColor = UIColor(red: CGFloat(redVal), green: CGFloat(greenVal), blue: CGFloat(blueVal), alpha: 1)
    }
    
    //MARK - UIImagePickerController Delegate Methods - For Picking of Background Image
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image: UIImage = info[UIImagePickerControllerEditedImage] as! UIImage
        backgroundImage = image
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
