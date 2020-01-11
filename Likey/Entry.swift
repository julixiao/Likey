//
//  Entry.swift
//  Likey
//
//  Created by Julie  on 2020-01-08.
//  Copyright © 2020 julixiao. All rights reserved.
//

import Cocoa
import Foundation

struct Entry : Codable {
    var title = ""
    var rating = ""
    var comments = ""
    
    init(title: String, rating: String, comments: String) {
        self.title   = title
        self.rating = rating
        self.comments  = comments
    }
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case rating = "Rating"
        case comments = "Comments"
    }
    
    func encodeJson(entry: Entry, filePath: URL) {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        //let jsonDict = try! encoder.encode(entry)

        if let jsonDict = try? encoder.encode(entry) {
            //if let path = Bundle.main.path(forResource: filePath, ofType: "json") {
            let pathAsURL = filePath
            let jsonString = String(data: jsonDict, encoding: String.Encoding.utf8)
            do {
                try jsonString?.appendLineToURL(fileURL: pathAsURL)
            }
            catch {
                print("Failed to write JSON data: \(error.localizedDescription)")
            }
        }
    }
    
    func decodeJsonFile(filePath: URL, row: Int) -> Entry {
        do {
            let jData = try Data(contentsOf: filePath, options: .mappedIfSafe)
            let decoder = JSONDecoder()
            let reviewsArray = try! decoder.decode([Entry].self, from: jData)
            return reviewsArray[row]
        } catch let err {
            print (err.localizedDescription)
        }
    
        let emptyEntry = Entry(title: "", rating: "", comments: "")
        return emptyEntry
    }
}

extension String {
    func appendLineToURL(fileURL: URL) throws {
        try (", \n" + self + "\n ]").appendToURL(fileURL: fileURL)
    }

    func appendToURL(fileURL: URL) throws {
        let data = self.data(using: String.Encoding.utf8)!
        try data.append(fileURL: fileURL)
    }
}

extension Data {
    func append(fileURL: URL) throws {
        if let fileHandle = FileHandle(forWritingAtPath: fileURL.path) {
            defer {
                fileHandle.closeFile()
            }
            var bracket = fileHandle.seekToEndOfFile()
            bracket = bracket-3
            fileHandle.seek(toFileOffset: bracket)
            fileHandle.write(self)
        }
        else {
            try write(to: fileURL, options: .atomic)
        }
    }
}
