//
//  ViewController.swift
//  Meme Maker
//
//  Created by Joshua Ching on 2016-04-03.
//  Copyright © 2016 Joshua Ching. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var imagePickerButton: UIBarButtonItem!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var cameraButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(.Camera)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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


}

