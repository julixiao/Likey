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
    
    @IBOutlet weak var setPrefsButton: NSButton!
    
    // Function for setting preferences button
    @IBAction func setPreferences(_ sender: Any) {
        filePath = URL(fileURLWithPath: filePathField.stringValue)
        currentFilePath.stringValue = filePath.absoluteString
        entries = Entry().initEntries()
        entries.remove(at: 0)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "update table"), object: nil)
    }
    
    // Function for cancel button
    @IBAction func cancelButton(_ sender: Any) {
        self.view.window?.windowController?.close()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        currentFilePath.stringValue = filePath.absoluteString
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }

}
