//
//  ViewController.swift
//  MemeMe
//
//  Created by Igor Vorobiov on 2/22/16.
//  Copyright © 2016 Igor Vorobiov. All rights reserved.
//

import UIKit

class EditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIToolbarDelegate, MemeImageViewDelegate {

    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var actionBar: UINavigationBar!
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var saveMemeButton: UIBarButtonItem!
    @IBOutlet weak var shareMemeButton: UIBarButtonItem!
    
    private var isFullScreen = false
    
    private var bottomTextField: UITextField?
    private var topTextField: UITextField?
    private var keyboardRect: CGRect?
    private var keyboardActive = false
    
    private let memeView = MemeImageView()
    
    var memeModel: MemeModel!
    
    var resultDelegate: EditorResultDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(.Camera)
        
        view.insertSubview(memeView, belowSubview: view.subviews.first!)
        memeView.delegate = self
        memeView.refreshWithModel(memeModel)
        saveMemeButton.enabled = false
        shareMemeButton.enabled = false
        
        if navigationController != nil {
            actionBar.hidden = true
        }
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
            
            view.frame.origin.y = 0
            
            keyboardRect = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
            
            if keyboardCoversBottomTextField(){
                
                let edges = calcEndges()
                
                let points = edges.takenHeight - edges.availableHeight + 10
                view.frame.origin.y -= points
            }
            
        }
        keyboardActive = true
    }
    
    func keyboardWillDisappear(notification: NSNotification){
        keyboardRect = nil
        view.frame.origin.y = 0
        keyboardActive = false
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

    private func toggleEditMode(){
        if isFullScreen {
            actionBar.hidden = false
            toolbar.hidden = false
            memeView.turnEditingModeOff()
            isFullScreen = false
            view.backgroundColor = UIColor.groupTableViewBackgroundColor()
        } else {
            actionBar.hidden = true
            toolbar.hidden = true
            memeView.turnEditingModeOn()
            isFullScreen = true
            view.backgroundColor = UIColor.blackColor()
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        if picker.sourceType == .Camera {
            
        } else {
            if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
                memeView.image = image
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
        if !keyboardActive {
            toggleEditMode()
        }
        
        if bottomTextField != nil {
            bottomTextField!.resignFirstResponder()
        }
        
        if topTextField != nil {
            topTextField!.resignFirstResponder()
        }
    }
    
    @IBAction func saveMeme(sender: UIBarButtonItem) {
        memeView.dumpToModel(memeModel!)
        resultDelegate?.editorDidSave(self)
    }
    
    @IBAction func cancelMeme(sender: UIBarButtonItem) {
        resultDelegate?.editorDidCancel(self)
    }
    
    func topLabelDidBeginEditing(textField: UITextField) {
        topTextField = textField
    }
    
    func topLabelDidEndEditing(textField: UITextField) {
        topTextField = nil
    }
    
    func bottomLabelDidBeginEditing(textField: UITextField) {
        bottomTextField = textField
    }
    
    func bottomLabelDidEndEditing(textField: UITextField) {
        bottomTextField = nil
        view.frame.origin.y = 0
    }
    
    func memeDidChange(){
        saveMemeButton.enabled = true
        shareMemeButton.enabled = true
    }
}

