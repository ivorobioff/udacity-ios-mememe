//
//  ModeSwitcherDelegate.swift
//  MemeMe
//
//  Created by Igor Vorobiov on 3/20/16.
//  Copyright © 2016 Igor Vorobiov. All rights reserved.
//

import UIKit

protocol ModeSwitcherDelegate {
    func modeWillCancel();
    func modeWillActivate()
}
