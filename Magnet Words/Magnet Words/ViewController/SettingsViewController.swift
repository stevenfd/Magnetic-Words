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
    var redVal: CGFloat = 0
    var greenVal: CGFloat = 0
    var blueVal: CGFloat = 0
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var redText: UITextField!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var greenText: UITextField!
    @IBOutlet weak var blueSlider: UISlider!
    @IBOutlet weak var blueText: UITextField!
    @IBOutlet weak var colorDisplay: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorDisplay.layer.borderWidth = 1.0
        colorDisplay.layer.borderColor = UIColor.black.cgColor
        
        changeColor()
    }
    
    //Method to allow the user to set a background image
    @IBAction func setBackgroundImage(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    //Actions
    @IBAction func actionColorChangeSlider(_ sender: Any) {
        changeColor()
    }
    
    //Functions
    func changeColor() {
        redVal = CGFloat(redSlider.value)
        greenVal = CGFloat(greenSlider.value)
        blueVal = CGFloat(blueSlider.value)
        
        colorDisplay.backgroundColor = UIColor(red: redVal, green: greenVal, blue: blueVal, alpha: 1)
        
        redText.text = String(format: "%0.1f", redVal * 255)
        greenText.text = String(format: "%0.1f", greenVal * 255)
        blueText.text = String(format: "%0.1f", blueVal * 255)
        
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
