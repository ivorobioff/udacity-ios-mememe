//
//  MemesListViewController.swift
//  MemeMe
//
//  Created by Igor Vorobiov on 3/19/16.
//  Copyright © 2016 Igor Vorobiov. All rights reserved.
//

import UIKit

class MemesListViewController: MemesViewController,  UITableViewDelegate, UITableViewDataSource, DataChangeDelegate {
   
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
        currentIndexPath = indexPath
    }

    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let indexPaths = [indexPath]
            MemeStorage.models.removeAtIndex(indexPath.row)
            dataDidDelete(indexPaths)
            getGridController()?.dataDidDelete(indexPaths)
        }
    }
    
    override func editorDidSave(editor: EditorViewController) {
        super.editorDidSave(editor)
        
        if !isEditingMode {
            let indexPaths = [NSIndexPath(forRow: MemeStorage.models.count - 1, inSection: 0)];
            dataDidInsert(indexPaths)
            getGridController()?.dataDidInsert(indexPaths)
        } else {
            let indexPaths = [currentIndexPath!]
            dataDidUpdate(indexPaths)
            getGridController()?.dataDidUpdate(indexPaths)
        }
    }
    
    func dataDidInsert(indexPaths: [NSIndexPath]){
        memeListView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
    }
    
    func dataDidUpdate(indexPaths: [NSIndexPath]){
        memeListView.reloadRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
    }
    
    func dataDidDelete(indexPaths: [NSIndexPath]){
        memeListView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
    }
}
