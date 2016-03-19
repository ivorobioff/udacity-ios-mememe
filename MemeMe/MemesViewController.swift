//
//  MemesViewController.swift
//  MemeMe
//
//  Created by Igor Vorobiov on 3/5/16.
//  Copyright © 2016 Igor Vorobiov. All rights reserved.
//

import UIKit

class MemesViewController: UIViewController, EditorResultDelegate {
    
    var isEditingMode = false
    
    var currentIndexPath: NSIndexPath?
    
    @IBAction func addMeme(sender: UIBarButtonItem) {
        performSegueWithIdentifier("toAddMeme", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        super.prepareForSegue(segue, sender: sender)
        
        let editor = segue.destinationViewController as! EditorViewController
        editor.resultDelegate = self
        
        if segue.identifier == "toAddMeme" {
            editor.memeModel = MemeModel()
            isEditingMode = false
        } else {
            editor.memeModel = sender as? MemeModel
            isEditingMode = true
        }
    }
    
    func getListController() -> MemesListViewController {
        let navController = self.tabBarController!.viewControllers!.first as! UINavigationController
        return navController.viewControllers.first as! MemesListViewController
    }
    
    func getGridController() -> MemesGridViewController? {
        let navController = self.tabBarController!.viewControllers!.last as? UINavigationController
        return navController?.viewControllers.first as? MemesGridViewController
    }
    
    func editorDidSave(editor: EditorViewController) {
        if !isEditingMode {
            MemeStorage.models.append(editor.memeModel!)
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    func editorDidCancel(editor: EditorViewController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
