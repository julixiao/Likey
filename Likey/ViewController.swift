//
//  ViewController.swift
//  Likey
//
//  Created by Julie  on 2019-03-24.
//  Copyright © 2019 julixiao. All rights reserved.
//
import Cocoa

var filePath = URL(fileURLWithPath: "/Users/Julie/Downloads/reviews.json")

class ViewController: NSViewController, NSTableViewDelegate, NSTableViewDataSource {

    @IBOutlet weak var tableView: NSTableView!
    
    @IBOutlet weak var titleField: NSTextField!
    
    @IBOutlet weak var commentsField: NSTextField!
    
    @IBOutlet weak var ratingField: NSLevelIndicator!
    
    @IBAction func addButton(_ sender: Any) {
        let newEntry = Entry(title: titleField.stringValue, rating: ratingField.stringValue, comments: commentsField.stringValue)
        newEntry.encodeJson(entry: newEntry, filePath: filePath)
    }
    
    func getFilePath() -> URL {
        return filePath
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        var rows = 0
        do {
            let jData = try Data(contentsOf: getFilePath(), options: .mappedIfSafe)
            if let reviewsArray = try JSONSerialization.jsonObject(with: jData, options: []) as? [Any] {
                for _ in reviewsArray {
                    rows += 1
                }
            }
        } catch let err {
            print (err.localizedDescription)
        }
        return rows
    }

    // returns Entry for respective cell
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let entry = Entry(title: "", rating: "", comments: "").decodeJsonFile(filePath: filePath, row: row)
        do {
            if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "reviewCell"), owner: nil) as? NSTableCellView {
                cell.textField?.stringValue = entry.title
                return cell
            }
        }
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
}
