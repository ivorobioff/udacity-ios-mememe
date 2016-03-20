//
//  ModeSwither.swift
//  MemeMe
//
//  Created by Igor Vorobiov on 3/20/16.
//  Copyright © 2016 Igor Vorobiov. All rights reserved.
//

import UIKit

class ModeSwitcher : NSObject, UIToolbarDelegate {
    private var controller: UIViewController
    
    private var leftButtons: [UIBarButtonItem]?
    private var rightButtons: [UIBarButtonItem]?
    private var toolBarItems: [UIBarButtonItem]?
    private var title: String?
    
    var isOn = false
    
    private lazy var cancelButton: UIBarButtonItem = {
        [unowned self] in
        return UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: "turnOff")
    }()
    
    private lazy var selectAllButton: UIBarButtonItem = {
        [unowned self] in
        return UIBarButtonItem(title: "Select All", style: .Plain, target: self, action: "selectAll")
    }()
    
    private lazy var trashButton: UIBarButtonItem = {
        [unowned self] in
        return UIBarButtonItem(barButtonSystemItem: .Trash, target: self, action: "removeAll")
    }()
    
    
    init(controller: UIViewController){
        self.controller = controller
        
        leftButtons = controller.navigationItem.leftBarButtonItems
        rightButtons = controller.navigationItem.rightBarButtonItems
        title = controller.navigationItem.title
        toolBarItems = controller.toolbarItems
        
        controller
    }
    
    func turnOn(){
        isOn = true
        controller.navigationItem.title = "Select Items"
        controller.navigationItem.leftBarButtonItems = [cancelButton]
        controller.navigationItem.rightBarButtonItems = [selectAllButton]
        
        let space = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
        
        controller.toolbarItems = [space, trashButton]
        controller.tabBarController!.tabBar.hidden = true
        controller.navigationController!.toolbarHidden = false
    }
    
    func turnOff(){
        isOn = false
        controller.navigationItem.title = title
        controller.navigationItem.leftBarButtonItems = leftButtons
        controller.navigationItem.rightBarButtonItems = rightButtons
        controller.toolbarItems = toolBarItems
        controller.navigationController!.toolbarHidden = true
        controller.tabBarController!.tabBar.hidden = false
    }
    
    func selectAll()
    {
        
    }
    
    func removeAll()
    {
        
    }
}
