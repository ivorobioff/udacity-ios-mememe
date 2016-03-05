//
//  MemeModel.swift
//  MemeMe
//
//  Created by Igor Vorobiov on 3/5/16.
//  Copyright © 2016 Igor Vorobiov. All rights reserved.
//

import UIKit

class MemeModel {
    var top: String?
    var bottom: String?
    var image: UIImage?
    
    func isEmpty() -> Bool{
        return top == nil && bottom == nil && image == nil
    }
}
