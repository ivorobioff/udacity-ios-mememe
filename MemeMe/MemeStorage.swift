//
//  MemeStorage.swift
//  MemeMe
//
//  Created by Igor Vorobiov on 3/5/16.
//  Copyright © 2016 Igor Vorobiov. All rights reserved.
//

import UIKit

class MemeStorage {
    static var models: [MemeModel] = {
        var c = [MemeModel]()
        
        for i in 1...20 {
            var m = MemeModel()
            m.image = UIImage()
            m.top = "top " + String(i)
            m.bottom = "bottom " + String(i)
            
            c.append(m)
        }
        
        return c
    }()
}
