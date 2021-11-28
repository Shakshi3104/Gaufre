//
//  AppDelegate.swift
//  Gaufre
//
//  Created by MacBook Pro on 2021/11/28.
//

import Cocoa
import SwiftUI

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    
    private let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        buildMenu()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }

    // MARK: - Build status bar
    func buildMenu() {
        
        if let statusBarButton = statusItem.button {
            statusBarButton.image = NSImage(systemSymbolName: "cpu",
                                            accessibilityDescription: "app icon")
            statusBarButton.image?.size = NSSize(width: 18.0, height: 18.0)
            statusBarButton.image?.isTemplate = true
            statusBarButton.target = self
        }
        
        // Each core load view
        let coreInfoMenuItem = NSMenuItem()
        coreInfoMenuItem.title = "Core Load"
        
        let waftersView = NSHostingView(rootView: WafersView())
        waftersView.frame = NSRect(x: 0, y: 0, width: 300, height: 250)
        
        let coreDetailMenuItem = NSMenuItem()
        coreDetailMenuItem.view = waftersView
        
        let coreInfoSubmenu = NSMenu()
        coreInfoSubmenu.addItem(coreDetailMenuItem)
        
        let mainMenu = NSMenu()
        mainMenu.addItem(coreInfoMenuItem)
        mainMenu.setSubmenu(coreInfoSubmenu, for: coreInfoMenuItem)
        
        // separater
        mainMenu.addItem(NSMenuItem.separator())
        
        // Quit
        mainMenu.addItem(withTitle: "Quit",
                         action: #selector(NSApplication.terminate(_:)),
                         keyEquivalent: "q")
        
        statusItem.menu = mainMenu
    }
}

