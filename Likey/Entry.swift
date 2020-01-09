//
//  Entry.swift
//  Likey
//
//  Created by Julie  on 2020-01-08.
//  Copyright © 2020 julixiao. All rights reserved.
//

import Cocoa
/*
class Entry: NSObject {
    
    static func getReviews(completion:((_ json: Data?) -> Void)) {
        completion(Data(reviews.utf8))
    }

    struct Entry : Codable {
        var title: String
        var rating: String
        var comments: String
    }

    func decodeData(pathName: URL){
        do{
            let jsonData = try Data(contentsOf: pathName)
            let decoder = JSONDecoder()
            entryList = try decoder.decode([Entry].self, from: jsonData)
        }
        catch {}
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
        
        // self.tableView.reloadData()
    }
    
    func readEntries(fileName: String) {
        guard let mainUrl = Bundle.main.url(forResource: fileName, withExtension: "json") else { return }
        
        do {
            let fileManager = FileManager.default
            let documentDirectory = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create:false)
            let subUrl = documentDirectory.appendingPathComponent(fileName)
            loadFile(mainPath: mainUrl, subPath: subUrl)
        } catch {
            print(error)
        }
    }
    
    func writeToFile(location: URL) {
        do{
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let JsonData = try encoder.encode(entryList)
            try JsonData.write(to: location)
        }
        catch{}
    }
    
}
*/
