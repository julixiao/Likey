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
    var creators = ""
    var rating = ""
    var comments = ""
    var latestDate = 0
    
    init(title: String, creators: String, rating: String, comments: String, latestDate: Int) {
        self.title = title
        self.creators = creators
        self.rating = rating
        self.comments  = comments
        self.latestDate = latestDate
    }
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case creators = "Creators"
        case rating = "Rating"
        case comments = "Comments"
        case latestDate = "Date"
    }
    
    func firstEncode(filePath: URL){
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        if let jsonDict = try? encoder.encode(self) {
            let jsonString = String(data: jsonDict, encoding: String.Encoding.utf8)
            do {
                try jsonString?.appendFirstLinetoURL(fileUrl: filePath)
            }
            catch {
                print("Failed to write JSON data: \(error.localizedDescription)")
            }
        }
    }
    
    func encodeJson(filePath: URL) {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted

        if let jsonDict = try? encoder.encode(self) {
            let jsonString = String(data: jsonDict, encoding: String.Encoding.utf8)
            do {
                try jsonString?.appendLineToURL(fileURL: filePath)
            }
            catch {
                print("Failed to write JSON data: \(error.localizedDescription)")
            }
        }
    }
    
    func decodeJsonFile (filePath: URL) -> [Entry]{
        do {
            let jData = try Data(contentsOf: filePath, options: .mappedIfSafe)
            let decoder = JSONDecoder()
            let reviewsArray = try! decoder.decode([Entry].self, from: jData)
            return reviewsArray
        } catch let err {
            print (err.localizedDescription)
        }
        let emptyList = [Entry(title: "", creators: "", rating: "", comments: "", latestDate: 0)]
        return emptyList
    }
    
    func getJsonEntry(filePath: URL, row: Int) -> Entry {
        return decodeJsonFile(filePath: filePath)[row]
    }
    
    func sortReviews(filePath: URL, sortMethod: String) {
        var reviewsArray = decodeJsonFile(filePath: filePath)
        if (sortMethod == "Title"){
            reviewsArray.sort{
                $0.title.lowercased() < $1.title.lowercased()
            }
        }
        else if (sortMethod == "Rating"){
            reviewsArray.sort{
                $0.rating > $1.rating
            }
        }
        else if (sortMethod == "Date"){
            reviewsArray.sort{
                $0.latestDate > $1.latestDate
            }
        }
        
        do{
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let JsonData = try encoder.encode(reviewsArray)
            try JsonData.write(to: filePath)
        }
        catch{}
    }
}

extension String {
    func appendFirstLinetoURL(fileUrl: URL) throws {
        try ("[ \n" + self + "\n ]").appendToURL(fileURL: filePath)
    }
    func appendLineToURL(fileURL: URL) throws {
        try (", \n" + self + "\n ]").appendToURL(fileURL: filePath)
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
            bracket = bracket-2
            fileHandle.seek(toFileOffset: bracket)
            fileHandle.write(self)
        }
        else {
            try write(to: fileURL, options: .atomic)
        }
    }
}
