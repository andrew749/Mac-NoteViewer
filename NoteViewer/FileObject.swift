//
//  FileObject.swift
//  NoteViewer
//
//  Created by Andrew Codispoti on 2016-07-12.
//  Copyright © 2016 andrewcodispoti. All rights reserved.
//

import Foundation

// ABC
class FileObject {
    func hasWord(query:String) -> Bool { return false }
    func getMatchingIndices(query:String) -> [PageIndex] { return  [] }
}