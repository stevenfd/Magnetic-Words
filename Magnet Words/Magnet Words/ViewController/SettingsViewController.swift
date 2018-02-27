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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //Method to allow the user to set a background image
    @IBAction func setBackgroundImage(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    
    //MARK - UIImagePickerController Delegate Methods - For Picking of Background Image
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image: UIImage = info[UIImagePickerControllerEditedImage] as! UIImage
        backgroundImage = image
        //(self.view as! UIImageView).contentMode = .center
        //(self.view as! UIImageView).image = backgroundImage
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
