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
    
    private let constraintManager = ConstraintManager()
    
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
    
    init(){
        super.init(image: nil)
        
        constraintManager.view = self
        
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

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var image: UIImage? {
        didSet {
            guard image != nil else {
                return
            }
            
            hidden = false
            refreshBounds()
            delegate?.memeDidChange()
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
        constraintManager.leading.active = flag
        constraintManager.trailing.active = flag
        constraintManager.height.active = flag
    }
    
    private func enableLandscapeConstraints(flag: Bool = true){
        constraintManager.top.active = flag
        constraintManager.bottom.active = flag
        constraintManager.width.active = flag
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
            constraintManager.width.constant = image!.size.width / r
        } else {
            let r = image!.size.width / frame.width
            constraintManager.height.constant = image!.size.height / r
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
    
    func refreshWithModel(model: MemeModel){
        image = model.image
        topTextField.text = model.top
        bottomTextField.text = model.bottom
        
        if topTextField.text == "" || topTextField.text == nil {
            topTextField.hidden = true
        } else {
            topTextField.hidden = false
        }
        
        if bottomTextField.text == "" || bottomTextField.text == nil {
            bottomTextField.hidden = true
        } else {
            bottomTextField.hidden = false
        }
    }
    
    func dumpToModel(model: MemeModel){
        model.bottom = bottomTextField.text
        model.top = topTextField.text
        model.image = image
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
        
        delegate?.memeDidChange()
    }
}
