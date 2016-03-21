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
    
    private var topLabel: UILabel!
    private var bottomLabel: UILabel!
    
    var model: MemeModel! {
        didSet {
            topLabel.text = model?.top
            bottomLabel.text = model?.bottom
            image = model?.image
        }
    }
    
    init() {
        super.init(image: nil)
        
        topLabel = createLabel()
        bottomLabel = createLabel()
        
        translatesAutoresizingMaskIntoConstraints = false
        constraintManager.view = self
        contentMode = .ScaleAspectFill
        
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
    
    
    private func createLabel() -> UILabel{
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
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
