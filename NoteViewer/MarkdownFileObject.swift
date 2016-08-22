//
//  MarkdownFileObject.swift
//  NoteViewer
//
//  Created by Andrew Codispoti on 2016-07-12.
//  Copyright © 2016 andrewcodispoti. All rights reserved.
//

import Foundation

class MarkdownFileObject: FileObject {
    
    // Stores raw text for markdown
    let fileContents:String
    let distance = 3
    
    // Stores user defined indices
    let definedIndices: [String: PageIndex] = [:]
    
    init (contents:String) {
       self.fileContents = contents
    }
    
    override func hasWord(query: String) -> Bool {
        return fileContents.containsString(query)
    }
    
    override func getMatchingIndices(query: String) -> [PageIndex] {
        var indices: [PageIndex] = []
        do {
            let pattern = query
            let regex = try NSRegularExpression( pattern: pattern, options: [])
            let ranges = regex.matchesInString(fileContents, options: [], range: NSMakeRange(0, fileContents.characters.count))
            indices.appendContentsOf(ranges.map({ (match) -> PageIndex in
                return PageIndex(characterPosition: match.range.location)
            }))
        } catch {
            
        }
        
        // Extend the array with successful searches on text
        indices.appendContentsOf(definedIndices.filter({ (s, index) -> Bool in
            return s.levenshtein(query) < distance
        }).map({ $0.1 }))
        return indices
    }
    
}