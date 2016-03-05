//
//  EditorResultDelegate.swift
//  MemeMe
//
//  Created by Igor Vorobiov on 3/5/16.
//  Copyright © 2016 Igor Vorobiov. All rights reserved.
//

import UIKit

protocol EditorResultDelegate {
    func editorDidCancel(editor: EditorViewController)
    func editorDidSave(editor: EditorViewController)
}
