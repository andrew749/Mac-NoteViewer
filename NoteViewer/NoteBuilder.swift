//
//  NoteBuilder.swift
//  NoteViewer
//
//  Created by Andrew Codispoti on 2016-07-12.
//  Copyright © 2016 andrewcodispoti. All rights reserved.
//

import Foundation
class NoteBuilder {
    // Compile a particular note and return the url of the new file
    class func compileNoteForPath(url:NSURL, name:String) -> NSURL? {
        // The template string:
        let tempFileName = "temp_page.md"
        let tempHTMLFileName = "temp_page.html"
        let temporaryDirectory = NSTemporaryDirectory()
        
        let markdownUrl = NSURL(fileURLWithPath: temporaryDirectory).URLByAppendingPathComponent(tempFileName)
        let htmlUrl = NSURL(fileURLWithPath: temporaryDirectory).URLByAppendingPathComponent(tempHTMLFileName)
        
        //reading
        do {
            // load data from file
            let text = try NSString(contentsOfURL: url, encoding: NSUTF8StringEncoding)
            
            // write the file to temp memory so we can safely edit it
            try text.writeToURL(markdownUrl, atomically: true, encoding: NSUTF8StringEncoding)
            
            // String for command to execute to compile
            let string = "/usr/local/bin/pandoc -s --mathjax -o \(htmlUrl.path!) \(markdownUrl.path!)"
            // execute the command
            system(string)
            
            return htmlUrl
        }
        catch {/* error handling here */}
        
        return nil
    }
}