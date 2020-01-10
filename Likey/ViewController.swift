//
//  ViewController.swift
//  Likey
//
//  Created by Julie  on 2019-03-24.
//  Copyright © 2019 julixiao. All rights reserved.
//
import Cocoa

// Bool newAddition = false

class ViewController: NSViewController, NSTableViewDelegate, NSTableViewDataSource {

    @IBOutlet weak var tableView: NSTableView!
    
    @IBOutlet weak var nameField: NSTextField!
    
    @IBOutlet weak var ratingField: NSLevelIndicator!
    
    @IBOutlet weak var reviewField: NSTextField!
    
    @IBAction func addButton(_ sender: Any) {
        
        //entryList[entryList.count].title = nameField.stringValue
        //entryList[entryList.count].rating = (String)(ratingField.intValue)
        //entryList[entryList.count].comments = reviewField.stringValue
        
//        newAddition = true
    }
    /*
    func decodeData(pathName: URL){
        do{
            let jsonData = try Data(contentsOf: pathName)
            let decoder = JSONDecoder()
            // entryList = try decoder.decode([Entry].self, from: jsonData)
        }
        catch {}
    }*/
    
    /* func readJsonFile(fileName: String) -> [Any]? {
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                let jData = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                if let reviewsArray = try JSONSerialization.jsonObject(with: jData, options: []) as? [Any] {
                    return reviewsArray
                }
            } catch let err {
                print (err.localizedDescription)
            }
        }
        return nil
    }*/
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        var rows = 0
        if let path = Bundle.main.path(forResource: "reviews", ofType: "json") {
            do {
                let jData = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                if let reviewsArray = try JSONSerialization.jsonObject(with: jData, options: []) as? [Any] {
                    for _ in reviewsArray {
                        rows += 1
                    }
                }
            } catch let err {
                print (err.localizedDescription)
            }
        }
        return rows
    }

    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        // Entry.getReviews { jsonData in
        //  guard let jData = jsonData else { return }
        let entry = Entry().decodeJsonFile(fileName: "reviews", row: row)
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



/* extension ViewController: NSTableViewDelegate {
    /*
    fileprivate enum CellIdentifiers {
        static let ReviewsCell = "ReviewsCellID"
    }
    
    
    func loadFile(mainPath: URL, subPath: URL){
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: subPath.path){
            decodeData(pathName: subPath)
            
            if entryList.isEmpty{
                decodeData(pathName: mainPath)
            }
            
        }else{
            decodeData(pathName: mainPath)
        }
        
        tableView.reloadData()
    }
        let fileManager = FileManager.default
        guard let mainUrl = Bundle.main.url(forResource: "reviews", withExtension: "json") else { return nil}
        
        do {
            let documentDirectory = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create:false)
            let subUrl = documentDirectory.appendingPathComponent("reviews")
            loadFile(mainPath: mainUrl, subPath: subUrl)
        } catch {
            print(error)
        }
 
        return nil
    }
 */

}
 */
