//
//  ViewController.swift
//  Likey
//
//  Created by Julie  on 2019-03-24.
//  Copyright © 2019 julixiao. All rights reserved.
//
import Cocoa

var filePath = URL(fileURLWithPath: "/Users/juliexiao/Downloads/reviews.json")

class ViewController: NSViewController, NSTableViewDelegate, NSTableViewDataSource {
    @IBOutlet weak var tableView: NSTableView!
    @IBOutlet weak var creatorsField: NSTextFieldCell!
    @IBOutlet weak var titleField: NSTextField!
    @IBOutlet weak var commentsField: NSTextField!
    @IBOutlet weak var ratingField: NSLevelIndicator!
    @IBOutlet weak var sortChoiceMenu: NSPopUpButton!
    @IBOutlet weak var entryActionButton: NSButton!
    
    var toDeleteIndex = 0
    var toViewIndex = 0
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return entries.count
    }
    
    func clearTextFields() {
        titleField.stringValue = ""
        ratingField.stringValue = ""
        commentsField.stringValue = ""
        creatorsField.stringValue = ""
    }
    
    // Deals with adding a new entry, editing an entry, and viewing an entry
    @IBAction func entryActionButton(_ sender: Any) {
        if entryActionButton.title == "Add" {
            let newEntry = Entry(title: titleField.stringValue, creators: creatorsField.stringValue, rating: ratingField.stringValue, comments: commentsField.stringValue, latestDate: Int(NSDate().timeIntervalSince1970))
            entries.append(newEntry)
            tableView.reloadData()
            clearTextFields()
            
            if (numberOfRows(in: tableView) == 0){
                newEntry.firstEncode(filePath: filePath)
            }
            else{
                newEntry.encodeJson(filePath: filePath)
            }
        }
        else if entryActionButton.title == "Edit" {
            entries.remove(at: toDeleteIndex)
            let newEntry = Entry(title: titleField.stringValue, creators: creatorsField.stringValue, rating: ratingField.stringValue, comments: commentsField.stringValue, latestDate: Int(NSDate().timeIntervalSince1970))
            entries.append(newEntry)
            clearTextFields()
            entryActionButton.title = "Add"
            tableView.reloadData()
            do{
                let encoder = JSONEncoder()
                encoder.outputFormatting = .prettyPrinted
                let JsonData = try encoder.encode(entries)
                try JsonData.write(to: filePath)
            }
            catch let err{
                print (err.localizedDescription)
            }
        }
        else if entryActionButton.title == "OK" {
            clearTextFields()
            tableView.deselectRow(tableView.selectedRow)
            entryActionButton.title = "Add"
        }
    }

    // Deals with sort option drop down menu
    @IBAction func sortFilter(_ sender: NSPopUpButton) {
        if let sortChoice = sortChoiceMenu.titleOfSelectedItem {
            sortChoiceMenu.setTitle(sortChoice)
            Entry().sortReviews(filePath: filePath, sortMethod: sortChoice)
            tableView.reloadData()
        }
    }

    // Deals with displaying each cell of table view
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let entry = entries[row]
        do {
            if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "reviewCell"), owner: nil) as? NSTableCellView {
                cell.textField?.stringValue = entry.title
                return cell
            }
        }
        return nil
    }
    
    // Deals with action if table view cell is selected
    func tableViewSelectionDidChange(_ notification: Notification) {
        viewEntry()
    }

    
    // Deals with viewing entry; triggered by selection of table view cell
    func viewEntry() {
        if tableView.selectedRow >= 0 {
            entryActionButton.title = "OK"
            let entry = entries[tableView.selectedRow]
            titleField.stringValue = entry.title
            commentsField.stringValue = entry.comments
            ratingField.stringValue = entry.rating
            creatorsField.stringValue = entry.creators
            
            toViewIndex = tableView.selectedRow
        }
    }
    
    // Deals with editing an entry; triggered by double click on table view cell
    @objc func tableViewEdit() {
        if tableView.clickedRow >= 0 {
            entryActionButton.title = "Edit"
            let entry = entries[tableView.clickedRow]
            titleField.stringValue = entry.title
            commentsField.stringValue = entry.comments
            ratingField.stringValue = entry.rating
            creatorsField.stringValue = entry.creators

            toDeleteIndex = tableView.clickedRow
        }
    }

    // When notified, function is called to reload table view
    @objc func updateTable(notification: NSNotification){
        //load data here
        self.tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.target = self
        tableView.doubleAction = #selector(tableViewEdit)
        NotificationCenter.default.addObserver(self, selector: #selector(updateTable), name: NSNotification.Name(rawValue: "update table"), object: nil)
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
}
