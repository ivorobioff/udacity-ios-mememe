//
//  MemesGridViewController.swift
//  MemeMe
//
//  Created by Igor Vorobiov on 3/19/16.
//  Copyright © 2016 Igor Vorobiov. All rights reserved.
//

import UIKit

class MemesGridViewController: MemesViewController, UICollectionViewDelegate, UICollectionViewDataSource, DataChangeDelegate {
    @IBOutlet weak var memeGridView: UICollectionView!
    
    private lazy var modeSwitcher: ModeSwitcher = {
        [unowned self] in
        return ModeSwitcher(controller: self, collection: self.memeGridView)
    }()
    
    private var isAppearing = false
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        isAppearing = true
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        isAppearing = false
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        modeSwitcher.turnOff()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        hidesBottomBarWhenPushed = true
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MemeStorage.models.count
    }
   
    @IBAction func turnSelectModeOn(sender: UIBarButtonItem) {
        modeSwitcher.turnOn()
    }
  
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("memeCell", forIndexPath: indexPath)
        
        let model = MemeStorage.models[indexPath.row]
        let thumb = ThumbImageView(model: model)
        cell.contentView.addSubview(thumb)

        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        if modeSwitcher.isOn == false {
            performSegueWithIdentifier("toEditMeme", sender: MemeStorage.models[indexPath.row])
        }
        
        currentIndexPath = indexPath
        
        collectionView.deselectItemAtIndexPath(indexPath, animated: false)
    }
  
    
    override func editorDidSave(editor: EditorViewController) {
        super.editorDidSave(editor)
        
        if !isEditingMode {
            let indexPaths = [NSIndexPath(forRow: MemeStorage.models.count - 1, inSection: 0)]
            dataDidInsert(indexPaths)
            getListController().dataDidInsert(indexPaths)
        } else {
            let indexPaths = [currentIndexPath!]
            dataDidUpdate(indexPaths)
            getListController().dataDidUpdate(indexPaths)
        }
    }
    
    func dataDidInsert(indexPaths: [NSIndexPath]){
        memeGridView?.insertItemsAtIndexPaths(indexPaths)
    }
    
    func dataDidUpdate(indexPaths: [NSIndexPath]){
        memeGridView?.reloadItemsAtIndexPaths(indexPaths)
    }
    
    func dataDidDelete(indexPaths: [NSIndexPath]){
        memeGridView?.deleteItemsAtIndexPaths(indexPaths)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if isAppearing == true {
            tabBarController!.tabBar.hidden = false
        }
    }
}
