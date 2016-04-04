//
//  ViewController.swift
//  Meme Maker
//
//  Created by Joshua Ching on 2016-04-03.
//  Copyright © 2016 Joshua Ching. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet var imagePickerButton: UIBarButtonItem!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var cameraButton: UIBarButtonItem!
    @IBOutlet var topTextField: UITextField!
    @IBOutlet var bottomTextField: UITextField!
    @IBOutlet var resetButton: UIBarButtonItem!
    
    let topTextFieldDefaultText = "TOP TEXT"
    let bottomTextFieldDefaultText = "BOTTOM TEXT"
    let emptyText = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(.Camera)

        topTextField.text = topTextFieldDefaultText
        bottomTextField.text = bottomTextFieldDefaultText
        topTextField.delegate = self
        bottomTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        if textField.text == topTextFieldDefaultText || textField.text == bottomTextFieldDefaultText{
            textField.text = emptyText
        }
        return true
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            self.imageView.image = image;
        }
        picker.dismissViewControllerAnimated(true, completion: nil)
    }

    func selectImage(sourceType: UIImagePickerControllerSourceType){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = sourceType
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func openImagePicker(){
        selectImage(.PhotoLibrary)
    }

    @IBAction func openCamera(){
        selectImage(.Camera)
    }
    
    @IBAction func resetMeme(){
        self.imageView.image = UIImage()
        self.topTextField.text = topTextFieldDefaultText
        self.bottomTextField.text = bottomTextFieldDefaultText
    }


}

