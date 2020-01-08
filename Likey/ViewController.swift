//
//  ViewController.swift
//  Likey
//
//  Created by Julie  on 2019-03-24.
//  Copyright © 2019 julixiao. All rights reserved.
//

import Cocoa

Bool newAddition = false

class ViewController: NSViewController {

    
    @IBOutlet weak var nameField: NSTextField!
    
    @IBOutlet weak var ratingField: NSLevelIndicator!
    
    @IBOutlet weak var reviewField: NSTextField!
    
    @IBAction func addButton(_ sender: Any) {
        
        entryList[entryList.count].title = nameField.stringValue
        entryList[entryList.count].rating = (String)(ratingField.intValue)
        entryList[entryList.count].comments = reviewField.stringValue
        
        newAddition = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}


