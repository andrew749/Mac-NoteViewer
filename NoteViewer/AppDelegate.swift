//
//  AppDelegate.swift
//  NoteViewer
//
//  Created by Andrew Codispoti on 2016-07-12.
//  Copyright © 2016 andrewcodispoti. All rights reserved.
//

import Cocoa
import Foundation

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    
    func applicationDidBecomeActive(notification: NSNotification) {
    }

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }
    
    func openDocument(sender: AnyObject) {
        if let vc = NSApplication.sharedApplication().mainWindow?.contentViewController  as? ViewController {
            vc.listDirectory()
        }
    }
    
}

