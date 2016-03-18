//
//  MemesViewController.swift
//  MemeMe
//
//  Created by Igor Vorobiov on 3/5/16.
//  Copyright © 2016 Igor Vorobiov. All rights reserved.
//

import UIKit

class MemesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, EditorResultDelegate {
    
    @IBOutlet weak var memeListView: UITableView!
    
    private var isEditing = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
    
    func editorDidSave(editor: EditorViewController) {
        
        if !isEditing {
            MemeStorage.models.append(editor.memeModel!)
            dismissViewControllerAnimated(true, completion: nil)
        }
        
        memeListView.reloadData()
    }
    
    func editorDidCancel(editor: EditorViewController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("toEditMeme", sender: MemeStorage.models[indexPath.row])
    }
}
