//
//  ViewController.swift
//  Meme Maker
//
//  Created by Joshua Ching on 2016-04-03.
//  Copyright © 2016 Joshua Ching. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var imagePickerButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func openImagePicker(){
        let imagePicker = UIImagePickerController()
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }

}

