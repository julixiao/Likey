//
//  SettingsViewController.swift
//  Likey
//
//  Created by Julie  on 2020-02-04.
//  Copyright © 2020 julixiao. All rights reserved.
//

import Cocoa

class PrefsViewController: NSViewController {
    
    @IBOutlet weak var filePathField: NSTextField!

    @IBOutlet weak var currentFilePath: NSTextField!
    
    @IBAction func setPreferences(_ sender: Any) {
        filePath = URL(fileURLWithPath: filePathField.stringValue)
        self.view.window?.windowController?.close()
        do {
            currentFilePath.stringValue = try String(contentsOf: filePath)
        }
        catch let err {
            print (err.localizedDescription)
        }
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        self.view.window?.windowController?.close()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }

}
