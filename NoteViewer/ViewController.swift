//
//  ViewController.swift
//  NoteViewer
//
//  Created by Andrew Codispoti on 2016-07-12.
//  Copyright © 2016 andrewcodispoti. All rights reserved.
//

import Cocoa
import WebKit

class ViewController: NSViewController, NSTableViewDelegate, NSTableViewDataSource {
    
    var data : [String] = []
    let cellIdentifier = "file_cell"
    var currentPath = ""
   
    @IBOutlet var searchField: NSSearchField!
    @IBOutlet var webView: WebView!
   
    @IBOutlet weak var tableView: NSTableView!
    
     override func viewDidLoad() {
        super.viewDidLoad()
        
        // setup the table view
        tableView.setDelegate(self)
        tableView.setDataSource(self)
    }
    
    override var representedObject: AnyObject? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return data.count
    }
    
    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        if let cell = tableView.makeViewWithIdentifier(cellIdentifier, owner: nil) as? NSTableCellView {
            cell.textField?.stringValue = data[row]
            return cell
        }
        return nil
    }
    
    func tableViewSelectionDidChange(notification: NSNotification) {
        guard let tv = notification.object as? NSTableView else {
            return
        }
        
        let index = tv.selectedRow
        
        guard index >= 0 && index < data.count else {
            return
        }
        
        let filePath = "\(currentPath)/\(data[index])"
        guard let url = NoteBuilder.compileNoteForPath(NSURL(fileURLWithPath: filePath), name: data[index]) else {
            return
        }
        
        webView.mainFrame.loadRequest(NSURLRequest(URL: url))
    }
    
    // Get a directory and filter out markdown files so we can render them
    func listDirectory() {
        let myOpenDialog: NSOpenPanel = NSOpenPanel()
        myOpenDialog.canChooseDirectories = true
        myOpenDialog.runModal()
        
        guard let path = myOpenDialog.URL?.path else {
            return
        }
        currentPath = path
        let fs: NSFileManager = NSFileManager.defaultManager()
        
        do {
            let contents: Array =  try fs.contentsOfDirectoryAtPath(path)
            let markddownRegex = try NSRegularExpression(pattern: "\\w*\\.md", options: .CaseInsensitive)
            let markdownFiles:[String] = contents.filter({ (element: String) -> Bool in
                return markddownRegex.matchesInString(element, options: [], range: NSRange(location: 0, length: element.characters.count)).count > 0
                });
            self.data = markdownFiles
            tableView.reloadData()
        } catch {
            
        }
    }
    
}

