//
//  ViewController.swift
//  MemeMe
//
//  Created by Igor Vorobiov on 2/22/16.
//  Copyright © 2016 Igor Vorobiov. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIToolbarDelegate{

    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var actionBar: UINavigationBar!
    
    private let picture = MemeImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(.Camera)
        
        view.insertSubview(picture, belowSubview: view.subviews.first!)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        if picker.sourceType == .Camera {
            
        } else {
            if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
                picture.image = image
            }
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }


    @IBAction func pickImage(sender: UIBarButtonItem) {
        
        let picker = UIImagePickerController()
        
        picker.sourceType = .PhotoLibrary
        
        picker.delegate = self
        
        presentViewController(picker, animated: true, completion: nil)
    }
    
    @IBAction func takePhoto(sender: UIBarButtonItem) {
        let picker = UIImagePickerController()
        
        picker.sourceType = .Camera
        
        picker.delegate = self
        
        presentViewController(picker, animated: true, completion: nil)
    }
    
    func positionForBar(bar: UIBarPositioning) -> UIBarPosition {
        return .TopAttached
    }
    
    override func viewDidLayoutSubviews() {
        actionBar.sizeToFit()
    }
}

