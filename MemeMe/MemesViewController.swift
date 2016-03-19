//
//  MemesViewController.swift
//  MemeMe
//
//  Created by Igor Vorobiov on 3/5/16.
//  Copyright © 2016 Igor Vorobiov. All rights reserved.
//

import UIKit

class MemesViewController: UIViewController, EditorResultDelegate, UITabBarDelegate {
    
    private var isEditing = false
    
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
    }
    
    func editorDidCancel(editor: EditorViewController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
