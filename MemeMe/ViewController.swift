//
//  ViewController.swift
//  MemeMe
//
//  Created by Igor Vorobiov on 2/22/16.
//  Copyright © 2016 Igor Vorobiov. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIToolbarDelegate, MemeImageViewDelegate {

    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var actionBar: UINavigationBar!
    @IBOutlet weak var toolbar: UIToolbar!
    
    private var isFullScreen = false
    
    private var bottomTextField: UITextField?
    private var viewMovedByPoints: CGFloat = 0
    private var keyboardRect: CGRect?
    
    private let meme = MemeImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(.Camera)
        
        view.insertSubview(meme, belowSubview: view.subviews.first!)
        
        meme.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        NSNotificationCenter.defaultCenter()
            .addObserver(self, selector: "keyboardWillAppear:", name: UIKeyboardWillShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter()
            .addObserver(self, selector: "keyboardWillDisappear:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(animated: Bool){
        super.viewWillDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: nil, object: nil)
    }
    
    func keyboardWillAppear(notification: NSNotification){
        
        if bottomTextField != nil {
            
            resetView()
            
            keyboardRect = (notification.userInfo![UIKeyboardFrameBeginUserInfoKey] as! NSValue).CGRectValue()
            
            if keyboardCoversBottomTextField(){
                
                let edges = calcEndges()
                
                viewMovedByPoints = edges.takenHeight - edges.availableHeight + 10
                view.frame.origin.y -= viewMovedByPoints
            }
            
        }
    }
    
    func keyboardWillDisappear(notification: NSNotification){
        keyboardRect = nil
        resetView()
    }
    
    private func calcEndges() -> (availableHeight: CGFloat, takenHeight: CGFloat){
        let tfRect = view.convertRect(bottomTextField!.bounds, fromView: bottomTextField!)
        
        let height = view.frame.size.height - keyboardRect!.size.height
        
        let y = tfRect.origin.y + tfRect.size.height
        
        return (height, y)
    }
    
    private func keyboardCoversBottomTextField() -> Bool {
        
        guard keyboardRect != nil && bottomTextField != nil else {
            return false
        }
        
        let edges = calcEndges()
        
        return edges.takenHeight > edges.availableHeight
    }
    
    private func resetView(){
        view.frame.origin.y += viewMovedByPoints
        viewMovedByPoints = 0
    }

    
    private func toggleEditMode(){
        if isFullScreen {
            actionBar.hidden = false
            toolbar.hidden = false
            meme.turnEditingModeOff()
            isFullScreen = false
            view.backgroundColor = UIColor.groupTableViewBackgroundColor()
        } else {
            actionBar.hidden = true
            toolbar.hidden = true
            meme.turnEditingModeOn()
            isFullScreen = true
            view.backgroundColor = UIColor.blackColor()
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
    
    func memeDidTap() {
        toggleEditMode()
    }
    
    func topLabelDidBeginEditing(textField: UITextField) {
        //
    }
    
    func topLabelDidEndEditing(textField: UITextField) {
        //
    }
    
    func bottomLabelDidBeginEditing(textField: UITextField) {
        bottomTextField = textField
    }
    
    func bottomLabelDidEndEditing(textField: UITextField) {
        bottomTextField = nil
        resetView()
    }
}

