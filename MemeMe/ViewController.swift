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
    @IBOutlet weak var toolbar: UIToolbar!
    
    private var isFullScreen = false
    
    private let meme = MemeImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(.Camera)
        
        view.insertSubview(meme, belowSubview: view.subviews.first!)
        
        meme.onTapped = toggleEditMode
    }
    
    private func toggleEditMode(){
        if isFullScreen {
            actionBar.hidden = false
            toolbar.hidden = false
            meme.turnEditingModeOff()
            isFullScreen = false
        } else {
            actionBar.hidden = true
            toolbar.hidden = true
            meme.turnEditingModeOn()
            isFullScreen = true
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        if picker.sourceType == .Camera {
            
        } else {
            if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
                meme.image = image
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

