//
//  AppDelegate.swift
//  Gaufre
//
//  Created by MacBook Pro on 2021/11/28.
//

import Cocoa
import SwiftUI
import CoreWafer
import DeviceHardware

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
        
        // if Intel Mac, status bar icon is fill icon
        let statusBarSymbolName = MacDeviceHardware.deviceHardware.processorName.contains("Apple") ? "grid.circle" : "grid.circle.fill"
        
        if let statusBarButton = statusItem.button {
            statusBarButton.image = NSImage(systemSymbolName: statusBarSymbolName,
                                            accessibilityDescription: "app icon")
            statusBarButton.image?.size = NSSize(width: 18.0, height: 18.0)
            statusBarButton.image?.isTemplate = true
            statusBarButton.target = self
        }
        
        // Each core load view
        let wafersView: NSView
        let coreCount: Int
        
        #if DEBUG
        coreCount = 56
        wafersView = NSHostingView(rootView: DebugWafersView(coreCount: coreCount) .scaleEffect(0.55))
        #else
        coreCount = MacDeviceHardware.deviceHardware.processorCount
        wafersView = NSHostingView(rootView: WafersView(processor: processor) .scaleEffect(0.55))
        #endif
        
        let width = coreCount < 30 ? 20 * coreCount + 40 : 20 * coreCount / 2 + 40
        let height = coreCount < 30 ? 100 : 160
        
        wafersView.frame = NSRect(x: 0, y: 0, width: width, height: height)
        
        let coreInfoItem = NSMenuItem()
        coreInfoItem.view = wafersView
        
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

