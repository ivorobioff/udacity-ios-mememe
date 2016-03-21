//
//  ModeSwither.swift
//  MemeMe
//
//  Created by Igor Vorobiov on 3/20/16.
//  Copyright © 2016 Igor Vorobiov. All rights reserved.
//

import UIKit

class ModeSwitcher : NSObject, UIToolbarDelegate, UICollectionViewDelegate {
    private var controller: UIViewController
    private var collection: UICollectionView
    
    private var leftButtons: [UIBarButtonItem]?
    private var rightButtons: [UIBarButtonItem]?
    private var toolBarItems: [UIBarButtonItem]?
    private var title: String?
    
    private var oldCollectionDelegate: UICollectionViewDelegate?
    
    var isOn = false
    
    private var allCellsSelected = false
    
    let defaultTitle = "Slselect Memes"
    
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
    
    init(controller: UIViewController, collection: UICollectionView){
        self.controller = controller
        self.collection = collection
        leftButtons = controller.navigationItem.leftBarButtonItems
        rightButtons = controller.navigationItem.rightBarButtonItems
        title = controller.navigationItem.title
        toolBarItems = controller.toolbarItems
    }
    
    func turnOn(){
        if isOn {
            return
        }
        
        isOn = true
        oldCollectionDelegate = collection.delegate
        collection.delegate = self
        controller.navigationItem.title = defaultTitle
        controller.navigationItem.leftBarButtonItems = [cancelButton]
        controller.navigationItem.rightBarButtonItems = [selectAllButton]
        
        let space = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
        
        controller.toolbarItems = [space, trashButton]
        controller.tabBarController!.tabBar.hidden = true
        controller.navigationController!.toolbarHidden = false
        
        collection.allowsMultipleSelection = true
    }
    
    func turnOff(){
        
        if isOn == false {
            return
        }
        
        deselectAllSelected()
        
        collection.delegate = oldCollectionDelegate
        controller.navigationItem.title = title
        controller.navigationItem.leftBarButtonItems = leftButtons
        controller.navigationItem.rightBarButtonItems = rightButtons
        controller.toolbarItems = toolBarItems
        controller.navigationController!.toolbarHidden = true
        controller.tabBarController!.tabBar.hidden = false
        collection.allowsMultipleSelection = false
        
        isOn = false
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collection.cellForItemAtIndexPath(indexPath)!
        selectCell(cell)
    }

    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collection.cellForItemAtIndexPath(indexPath)!
        deselectCell(cell)
    }
    
    func selectCell(cell: UICollectionViewCell){
        cell.layer.borderWidth = 2.0
        cell.layer.borderColor = UIColor(red: 14/255, green: 122/255, blue: 254/255, alpha: 1).CGColor
        
        controller.navigationItem.title = String(getTotalSelectedCells()) + " Memes Selected"
    }

    func deselectCell(cell: UICollectionViewCell){
        cell.layer.borderWidth = 0
        let totalSelectedItems = getTotalSelectedCells()
        
        if totalSelectedItems > 0 {
            controller.navigationItem.title = String(totalSelectedItems) + " Memes Selected"
        } else {
            controller.navigationItem.title = defaultTitle
        }
    }
    
    func deselectAllSelected() {
        for indexPath in collection.indexPathsForSelectedItems() ?? [] {
            collection.deselectItemAtIndexPath(indexPath, animated: true)
            
            if let cell = collection.cellForItemAtIndexPath(indexPath) {
                deselectCell(cell)
            }
        }
    }
    
    func getTotalSelectedCells() -> Int{
        return (collection.indexPathsForSelectedItems() ?? []).count
    }
    
    func selectAll()
    {
        allCellsSelected = true
    }
    
    func removeAll()
    {
        
    }
}
