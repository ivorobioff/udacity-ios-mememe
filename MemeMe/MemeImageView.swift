//
//  MemeImageView.swift
//  MemeMe
//
//  Created by Igor Vorobiov on 2/24/16.
//  Copyright © 2016 Igor Vorobiov. All rights reserved.
//

import UIKit

class MemeImageView: UIImageView, UITextFieldDelegate {
    
    var delegate: MemeImageViewDelegate?
    
    private let placeholderStyle: [String: AnyObject] = [
        NSStrokeColorAttributeName: UIColor.blackColor(),
        NSStrokeWidthAttributeName: -2.0,
        NSForegroundColorAttributeName: UIColor(red:1.0, green:1.0, blue:1.0, alpha:0.5),
        NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size:  35)!
    ]
    
    private lazy var leadingConstraint: NSLayoutConstraint = {
        [unowned self] in
        return self.leadingAnchor.constraintEqualToAnchor(self.superview!.leadingAnchor)
    }()
    
    private lazy var trailingConstraint: NSLayoutConstraint = {
        [unowned self] in
        return self.trailingAnchor.constraintEqualToAnchor(self.superview!.trailingAnchor)
    }()
    
    private lazy var heightConstraint: NSLayoutConstraint = {
        [unowned self] in
        return self.heightAnchor.constraintEqualToConstant(0)
    }()
    
    
    private lazy var topConstraint: NSLayoutConstraint = {
        [unowned self] in
        return self.topAnchor.constraintEqualToAnchor(self.superview!.topAnchor)
    }()
    
    private lazy var bottomConstraint: NSLayoutConstraint = {
        [unowned self] in
        return self.bottomAnchor.constraintEqualToAnchor(self.superview!.bottomAnchor)
    }()
    
    private lazy var widthConstraint: NSLayoutConstraint = {
        [unowned self] in
        return self.widthAnchor.constraintEqualToConstant(0)
    }()
    
    private lazy var topTextField: UITextField = {
        [unowned self] in
        
        let textField = UITextField()
        
        MemeImageView.prepareTextField(textField)
        
        textField.attributedPlaceholder = NSAttributedString(string: "Top", attributes: self.placeholderStyle)
        
        return textField
    }()
    
    private lazy var bottomTextField: UITextField = {
        [unowned self] in
        
        let textField = UITextField()
        
        MemeImageView.prepareTextField(textField)
        
        textField.attributedPlaceholder = NSAttributedString(string: "Bottom", attributes: self.placeholderStyle)
        
        return textField
    }()
    
    convenience init(){
        self.init(image: nil)
        translatesAutoresizingMaskIntoConstraints = false
        contentMode = .ScaleAspectFit
        userInteractionEnabled = true
        hidden = true
        turnEditingModeOff()
        
        let tap = UITapGestureRecognizer(target: self, action: "didTap")
        tap.numberOfTapsRequired = 1
        
        addGestureRecognizer(tap)
        
        addSubview(topTextField)
        addSubview(bottomTextField)
        
        topTextField.delegate = self
        bottomTextField.delegate = self
        
        topTextField.topAnchor.constraintEqualToAnchor(topAnchor, constant: 20).active = true
        topTextField.leadingAnchor.constraintEqualToAnchor(leadingAnchor).active = true
        topTextField.trailingAnchor.constraintEqualToAnchor(trailingAnchor).active = true
        
        bottomTextField.bottomAnchor.constraintEqualToAnchor(bottomAnchor, constant: -20).active = true
        bottomTextField.leadingAnchor.constraintEqualToAnchor(leadingAnchor).active = true
        bottomTextField.trailingAnchor.constraintEqualToAnchor(trailingAnchor).active = true
    }
    
    override var image: UIImage? {
        didSet {
            guard image != nil else {
                return
            }
            
            hidden = false
            refreshBounds()
        }
    }
    
    func didTap(){
        delegate?.memeDidTap()
    }
    
    private static func prepareTextField(textField: UITextField){
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .None
        textField.spellCheckingType = .No
        textField.autocorrectionType = .No
        textField.textAlignment = .Center
        
        textField.defaultTextAttributes[NSStrokeColorAttributeName] = UIColor.blackColor()
        textField.defaultTextAttributes[NSStrokeWidthAttributeName] = -2.0
        textField.defaultTextAttributes[NSForegroundColorAttributeName] = UIColor.whiteColor()
        textField.defaultTextAttributes[NSFontAttributeName] = UIFont(name: "HelveticaNeue-CondensedBlack", size:  35)
    }
    
    private func adjustToLandscape(){
        enablePortraitConstraits(false)
        enableLandscapeConstraints()
    }
    
    private func adjustToPortrait(){
        enableLandscapeConstraints(false)
        enablePortraitConstraits()
    }
    
    private func enablePortraitConstraits(flag: Bool = true){
        leadingConstraint.active = flag
        trailingConstraint.active = flag
        heightConstraint.active = flag
    }
    
    private func enableLandscapeConstraints(flag: Bool = true){
        topConstraint.active = flag
        bottomConstraint.active = flag
        widthConstraint.active = flag
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        centerXAnchor.constraintEqualToAnchor(superview!.centerXAnchor).active = true
        centerYAnchor.constraintEqualToAnchor(superview!.centerYAnchor).active = true
    }
    
    override func layoutSublayersOfLayer(layer: CALayer) {
        
        super.layoutSublayersOfLayer(layer)
        
        if isLandscape() {
            adjustToLandscape()
        } else {
            adjustToPortrait()
        }
        
        refreshBounds()
    }
    
  
    private func refreshBounds() {
        
        guard image != nil else {
            return
        }
        
        if isLandscape() {
            let r = image!.size.height / frame.height
            widthConstraint.constant = image!.size.width / r
        } else {
            let r = image!.size.width / frame.width
            heightConstraint.constant = image!.size.height / r
        }
    }
    
    private func isLandscape() -> Bool {
        let h = superview!.frame.height
        let w = superview!.frame.width
        
        return w > h
    }
    
    func turnEditingModeOn(){
        topTextField.enabled = true
        bottomTextField.enabled = true
        topTextField.hidden = false
        bottomTextField.hidden = false
    }
    
    func turnEditingModeOff(){
        topTextField.enabled = false
        bottomTextField.enabled = false
        
        if topTextField.text == "" {
            topTextField.hidden = true
        }
        
        if bottomTextField.text == "" {
            bottomTextField.hidden = true
        }
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if textField === topTextField {
            delegate?.topLabelDidBeginEditing(textField)
        }
        
        if textField === bottomTextField {
            delegate?.bottomLabelDidBeginEditing(textField)
        }
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        if textField === topTextField {
            delegate?.topLabelDidEndEditing(textField)
        }
        
        if textField === bottomTextField {
            delegate?.bottomLabelDidEndEditing(textField)
        }
    }
}
