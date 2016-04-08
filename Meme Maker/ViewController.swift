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
    @IBOutlet var shareButton: UIBarButtonItem!
    @IBOutlet var toolBar: UIToolbar!
    
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
    
    override func viewWillAppear(animated: Bool){
        super.viewWillAppear(animated)
        self.subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.unsubscribeFromKeyboardNotifications()
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
    
    func subscribeToKeyboardNotifications(){
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "shiftViewForKeyboard:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "unshiftViewForKeyboard:", name: UIKeyboardWillHideNotification, object:nil)
    }
    
    func unsubscribeFromKeyboardNotifications(){
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func shiftViewForKeyboard(notification: NSNotification){
        self.view.frame.origin.y -= getKeyboardHeight(notification)
    }
    
    func unshiftViewForKeyboard(notification: NSNotification){
        self.view.frame.origin.y += getKeyboardHeight(notification)
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat{
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.CGRectValue().height
    }
    
    func createMemeImage() -> UIImage{
        self.toolBar.hidden = true
        self.view.backgroundColor = UIColor.blackColor()
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        
        view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true)
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        self.toolBar.hidden = false
        self.view.backgroundColor = UIColor.whiteColor()
        
        return memedImage
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
    
    @IBAction func share(){
        let image = createMemeImage()
        let toLaunch = UIActivityViewController(activityItems: [image],applicationActivities: nil)
        self.presentViewController(toLaunch, animated: true, completion: nil)
        
    }


}

