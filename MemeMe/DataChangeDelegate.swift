//
//  DataChangeDelegate.swift
//  MemeMe
//
//  Created by Igor Vorobiov on 3/19/16.
//  Copyright © 2016 Igor Vorobiov. All rights reserved.
//

import UIKit

protocol DataChangeDelegate {
    func dataDidInsert(indexPaths: [NSIndexPath])
    func dataDidUpdate(indexPaths: [NSIndexPath])
    func dataDidDelete(indexPaths: [NSIndexPath])
}
