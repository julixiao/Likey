//
//  Entry.swift
//  Likey
//
//  Created by Julie  on 2020-01-08.
//  Copyright © 2020 julixiao. All rights reserved.
//

import Cocoa

class Entry: NSObject {
    
    struct Entry : Codable {
        var title = ""
        var rating = ""
        var comments = ""
        
        enum CodingKeys: String, CodingKey {
            case title = "Title"
            case rating = "Rating"
            case comments = "Comments"
        }
    }

    func decodeJsonFile(fileName: String, row: Int) -> Entry {
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                let jData = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let decoder = JSONDecoder()
                let reviewsArray = try! decoder.decode([Entry].self, from: jData)
                return reviewsArray[row]
            } catch let err {
                print (err.localizedDescription)
            }
        }
        let emptyEntry = Entry()
        return emptyEntry
    }
}
    /*
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
