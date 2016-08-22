//
//  PageIndex.swift
//  NoteViewer
//
//  Created by Andrew Codispoti on 2016-07-13.
//  Copyright © 2016 andrewcodispoti. All rights reserved.
//

import Foundation

// Types of indices stored
enum IndexType {
    case IMAGE_INDEX
    case MARKDOWN_INDEX
}

// We want this to remain static
// This is a composite class
class PageIndex {
    
    enum PageIndexException: ErrorType {
        case InvalidOperation
    }
    
    // Store the dimensions of the page so we can store relative position (in whatever units were working with)
    private let pageWidth:Float
    private let pageHeight:Float
    private let positionX: Float
    private let positionY: Float
    private let characterPosition: Int
    private let type:IndexType
    
    // We store the page width and height
    init(pageWidth:Float, pageHeight:Float, positionX:Float, positionY:Float) {
        self.pageWidth = pageWidth
        self.pageHeight = pageHeight
        self.positionX = positionX
        self.positionY = positionY
        self.characterPosition = 0
        self.type = .IMAGE_INDEX
    }
    
    // If this is a class for a text based document
    init (characterPosition:Int) {
        self.characterPosition = characterPosition
        self.pageHeight = 0
        self.pageWidth = 0
        self.positionX = 0
        self.positionY = 0
        self.type = .MARKDOWN_INDEX
    }
    
    func getTextIndex() throws -> Int {
        guard self.type == .MARKDOWN_INDEX else {
            throw PageIndexException.InvalidOperation
        }
        return self.characterPosition
    }
    
    func getPageDimensions() throws -> (pageWidth:Float, pageHeight:Float) {
        guard self.type == .IMAGE_INDEX else {
            throw PageIndexException.InvalidOperation
        }
        return (self.pageWidth, self.pageHeight)
    }
    
    
    
}