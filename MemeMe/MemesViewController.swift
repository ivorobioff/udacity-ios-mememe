//
//  MemesViewController.swift
//  MemeMe
//
//  Created by Igor Vorobiov on 3/5/16.
//  Copyright © 2016 Igor Vorobiov. All rights reserved.
//

import UIKit

class MemesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,
    EditorResultDelegate, UITabBarDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var memeListView: UITableView!
    @IBOutlet weak var memeGridView: UICollectionView!
    
    
    @IBOutlet weak var viewSwitcher: UITabBar!
    
    private var isEditing = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSwitcher.delegate = self
        viewSwitcher.selectedItem = viewSwitcher.items!.first
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MemeStorage.models.count
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MemeStorage.models.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("memeCell") as! MemeTableViewCell
        
        let model = MemeStorage.models[indexPath.row]
        
        cell.thumb.image = model.image
        cell.topText.text = model.top
        cell.bottomText.text = model.bottom
        
            
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("memeCell", forIndexPath: indexPath)
        
        let model = MemeStorage.models[indexPath.row]
        
        let image = UIImageView(frame: CGRectMake(0, 0, 80, 80))
        image.image = model.image
        image.contentMode = .ScaleAspectFill
        
        cell.contentView.addSubview(image)
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    @IBAction func addMeme(sender: UIBarButtonItem) {
        performSegueWithIdentifier("toAddMeme", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        super.prepareForSegue(segue, sender: sender)
        
        let editor = segue.destinationViewController as! EditorViewController
        editor.resultDelegate = self
        
        if segue.identifier == "toAddMeme" {
            editor.memeModel = MemeModel()
            isEditing = false
        } else {
            editor.memeModel = sender as? MemeModel
            isEditing = true
        }
    
    }
    
    func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
        
        if item.tag == 1 {
            memeListView.hidden = false
            memeGridView.hidden = true
        }
        
        if item.tag == 2 {
            memeListView.hidden = true
            memeGridView.hidden = false
        }
    }
    
    func editorDidSave(editor: EditorViewController) {
        
        if !isEditing {
            MemeStorage.models.append(editor.memeModel!)
            dismissViewControllerAnimated(true, completion: nil)
        }
        
        memeListView.reloadData()
        memeGridView.reloadData()
    }
    
    func editorDidCancel(editor: EditorViewController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("toEditMeme", sender: MemeStorage.models[indexPath.row])
    }
}
