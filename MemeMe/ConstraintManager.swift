//
//  ConstraintManager.swift
//  MemeMe
//
//  Created by Igor Vorobiov on 3/19/16.
//  Copyright © 2016 Igor Vorobiov. All rights reserved.
//

import UIKit

class ConstraintManager {
    
    var view: UIView!
    
    lazy var leading: NSLayoutConstraint = {
        [unowned self] in
        return self.view.leadingAnchor.constraintEqualToAnchor(self.view.superview!.leadingAnchor)
    }()
    
    lazy var trailing: NSLayoutConstraint = {
        [unowned self] in
        return self.view.trailingAnchor.constraintEqualToAnchor(self.view.superview!.trailingAnchor)
    }()
    
    lazy var height: NSLayoutConstraint = {
        [unowned self] in
        return self.view.heightAnchor.constraintEqualToConstant(0)
    }()
    
    lazy var top: NSLayoutConstraint = {
        [unowned self] in
        return self.view.topAnchor.constraintEqualToAnchor(self.view.superview!.topAnchor)
    }()
    
    lazy var bottom: NSLayoutConstraint = {
        [unowned self] in
        return self.view.bottomAnchor.constraintEqualToAnchor(self.view.superview!.bottomAnchor)
    }()
    
    lazy var width: NSLayoutConstraint = {
        [unowned self] in
        return self.view.widthAnchor.constraintEqualToConstant(0)
    }()
}