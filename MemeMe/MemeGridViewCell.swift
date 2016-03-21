//
//  MemeGridViewCell.swift
//  MemeMe
//
//  Created by Igor Vorobiov on 3/21/16.
//  Copyright © 2016 Igor Vorobiov. All rights reserved.
//

import UIKit

class MemeGridViewCell: UICollectionViewCell {
    
    lazy var thumb: ThumbImageView = {
        [unowned self] in
        
        let t = ThumbImageView()
        
        self.addSubview(t)
        
        return t
    }()
}
