//
//  MemeImageViewDelegate.swift
//  MemeMe
//
//  Created by Igor Vorobiov on 2/27/16.
//  Copyright © 2016 Igor Vorobiov. All rights reserved.
//

import UIKit

protocol MemeImageViewDelegate {
    func memeDidTap()
    func topLabelDidBeginEditing(textField: UITextField)
    func topLabelDidEndEditing(textField: UITextField)
    func bottomLabelDidBeginEditing(textField: UITextField)
    func bottomLabelDidEndEditing(textField: UITextField)
}
