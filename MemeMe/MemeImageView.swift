//
//  MemeImageView.swift
//  MemeMe
//
//  Created by Igor Vorobiov on 2/24/16.
//  Copyright © 2016 Igor Vorobiov. All rights reserved.
//

import UIKit

class MemeImageView: UIImageView {
    
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
    
    convenience init(){
        self.init(image: nil)
        translatesAutoresizingMaskIntoConstraints = false
        contentMode = .ScaleAspectFit
    }
    
    override var image: UIImage? {
        didSet {
            guard image != nil else {
                return
            }
            
            refreshBounds()
        }
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
}
