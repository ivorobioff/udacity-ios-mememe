//
//  MemesListViewController.swift
//  MemeMe
//
//  Created by Igor Vorobiov on 3/19/16.
//  Copyright © 2016 Igor Vorobiov. All rights reserved.
//

import UIKit

class MemesListViewController: MemesViewController,  UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var memeListView: UITableView!
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("memeCell") as! MemeTableViewCell
        
        let model = MemeStorage.models[indexPath.row]
        
        cell.thumb.image = model.image
        cell.topText.text = model.top
        cell.bottomText.text = model.bottom
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MemeStorage.models.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("toEditMeme", sender: MemeStorage.models[indexPath.row])
    }

    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            MemeStorage.models.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
    }
    
    override func editorDidSave(editor: EditorViewController) {
        super.editorDidSave(editor)
        
        memeListView.insertRowsAtIndexPaths([NSIndexPath(forRow: MemeStorage.models.count - 1, inSection: 0)], withRowAnimation: .Automatic)
    }
}
