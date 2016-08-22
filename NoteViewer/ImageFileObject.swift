//
//  ImageFileObject.swift
//  NoteViewer
//
//  Created by Andrew Codispoti on 2016-07-12.
//  Copyright © 2016 andrewcodispoti. All rights reserved.
//

import Foundation

// File object to represent an image
class ImageFileObject: FileObject {
    
    var computedIndices: [String: PageIndex] = [:]
    let distanceParameter = 2
    
    override init ()  {
    }
    
    override func hasWord(query:String) -> Bool {
        // if we find the index in the image
        if let _ = computedIndices[query] {
           return true
        }
        return false
    }
    
    //filter by matching query
    override func getMatchingIndices(query:String) -> [PageIndex] {
        let filteredIndices = computedIndices.filter({ (s:String, i:PageIndex) -> Bool in
            // calculate levenshtein distance
            return s.levenshtein(query) < distanceParameter
        })
        return filteredIndices.map( { $0.1 } )
    }
}