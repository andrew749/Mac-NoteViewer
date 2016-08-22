//
//  SearchHelper.swift
//  NoteViewer
//
//  Created by Andrew Codispoti on 2016-07-13.
//  Copyright © 2016 andrewcodispoti. All rights reserved.
//

import Foundation

private extension String {
    
    subscript(index: Int) -> Character {
        return self[startIndex.advancedBy(index)]
    }
    
    subscript(range: Range<Int>) -> String {
        let start = startIndex.advancedBy(range.startIndex)
        let end = startIndex.advancedBy(range.endIndex)
        return self[start..<end]
    }
}

extension String {
    
    func levenshtein(cmpString: String) -> Int {
        let (length, cmpLength) = (characters.count, cmpString.characters.count)
        var matrix = Array(
            count: cmpLength + 1,
            repeatedValue: Array(
                count: length + 1,
                repeatedValue: 0
            )
        )
        
        for m in 1..<cmpLength {
            matrix[m][0] = matrix[m - 1][0] + 1
        }
        
        for n in 1..<length {
            matrix[0][n] = matrix[0][n - 1] + 1
        }
        
        for m in 1..<(cmpLength + 1) {
            for n in 1..<(length + 1) {
                let penalty = self[n - 1] == cmpString[m - 1] ? 0 : 1
                let (horizontal, vertical, diagonal) = (matrix[m - 1][n] + 1, matrix[m][n - 1] + 1, matrix[m - 1][n - 1])
                matrix[m][n] = min(horizontal, vertical, diagonal + penalty)
            }
        }
        
        return matrix[cmpLength][length]
    }
}