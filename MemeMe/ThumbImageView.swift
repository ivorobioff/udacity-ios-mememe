//
//  ThumbImageView.swift
//  MemeMe
//
//  Created by Igor Vorobiov on 3/19/16.
//  Copyright © 2016 Igor Vorobiov. All rights reserved.
//

import UIKit

class ThumbImageView: UIImageView {
    
    private let constraintManager = ConstraintManager()
    
    init(model: MemeModel) {
        super.init(image: model.image)
        translatesAutoresizingMaskIntoConstraints = false
        constraintManager.view = self
        contentMode = .ScaleAspectFill
        
        let topLabel = createLabel(model.top)
        let bottomLabel = createLabel(model.bottom)
        
        addSubview(topLabel)
        addSubview(bottomLabel)
        
        setupConstraints(topLabel)
        topLabel.topAnchor.constraintEqualToAnchor(topAnchor).active = true
        
        setupConstraints(bottomLabel)
        bottomLabel.bottomAnchor.constraintEqualToAnchor(bottomAnchor).active = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()

        constraintManager.leading.active = true
        constraintManager.trailing.active = true
        constraintManager.top.active = true
        constraintManager.bottom.active = true
    }
    
    
    private func createLabel(text: String?) -> UILabel{
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.textColor = UIColor.whiteColor()
        label.font = UIFont.boldSystemFontOfSize(12)
        label.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.5)
        label.textAlignment = .Center
        
        return label
    }
    
    private func setupConstraints(label: UILabel){
        label.heightAnchor.constraintEqualToConstant(30).active = true
        label.leadingAnchor.constraintEqualToAnchor(leadingAnchor).active = true
        label.trailingAnchor.constraintEqualToAnchor(trailingAnchor).active = true
    }
}
