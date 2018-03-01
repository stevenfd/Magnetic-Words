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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorDisplay.layer.borderWidth = 1.0
        colorDisplay.layer.borderColor = UIColor.black.cgColor
        
        updateTextColorValue()
        updateSliderColorValue()
        updateColorDisplayValue()
        
        changeBackgroundType(colorSwitch)
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
            colorSwitch.setOn(!imageSwitch.isOn, animated: true)
        } else {
            imageSwitch.setOn(!colorSwitch.isOn, animated: true)
        }
        
        backgroundIsImage = imageSwitch.isOn
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
        redVal = redSlider.value
        greenVal = greenSlider.value
        blueVal = blueSlider.value
        
        updateSliderColorValue()
        updateColorDisplayValue()
    }
    
    //Functions
    func updateTextColorValue() {
        redText.text = String(format: "%0.1f", redVal * 255)
        greenText.text = String(format: "%0.1f", greenVal * 255)
        blueText.text = String(format: "%0.1f", blueVal * 255)
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
