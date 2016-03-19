//
//  MemesGridViewController.swift
//  MemeMe
//
//  Created by Igor Vorobiov on 3/19/16.
//  Copyright © 2016 Igor Vorobiov. All rights reserved.
//

import UIKit

class MemesGridViewController: MemesViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var memeGridView: UICollectionView!
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MemeStorage.models.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("memeCell", forIndexPath: indexPath)
        
        let model = MemeStorage.models[indexPath.row]
        let thumb = ThumbImageView(model: model)
        cell.contentView.addSubview(thumb)
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("toEditMeme", sender: MemeStorage.models[indexPath.row])
    }
    
    override func editorDidSave(editor: EditorViewController) {
        super.editorDidSave(editor)
        memeGridView.reloadData()
    }
}
