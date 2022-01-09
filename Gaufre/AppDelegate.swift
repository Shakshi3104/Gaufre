//
//  AppDelegate.swift
//  Gaufre
//
//  Created by MacBook Pro on 2021/11/28.
//

import Cocoa
import SwiftUI
import CoreWafer

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    
    private let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    private var processor = ProcessorObserver()

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        buildMenu()
        
        processor.start()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
        processor.cancel()
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }

    // MARK: - Build status bar
    func buildMenu() {
        
        if let statusBarButton = statusItem.button {
            statusBarButton.image = NSImage(systemSymbolName: "grid.circle",
                                            accessibilityDescription: "app icon")
            statusBarButton.image?.size = NSSize(width: 18.0, height: 18.0)
            statusBarButton.image?.isTemplate = true
            statusBarButton.target = self
        }
        
        // Each core load view        
        let waftersView = NSHostingView(rootView: WafersView(processor: processor) .scaleEffect(0.55))
        waftersView.frame = NSRect(x: 0, y: 0, width: 200, height: 100)
        
        let coreInfoItem = NSMenuItem()
        coreInfoItem.view = waftersView
        
        // main menu
        let mainMenu = NSMenu()
        mainMenu.addItem(coreInfoItem)
        
        // separater
        mainMenu.addItem(NSMenuItem.separator())
        
        // Quit
        mainMenu.addItem(withTitle: "Quit",
                         action: #selector(NSApplication.terminate(_:)),
                         keyEquivalent: "q")
        
        statusItem.menu = mainMenu
    }
}

