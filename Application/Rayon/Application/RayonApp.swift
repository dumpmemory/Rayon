//
//  RayonApp.swift
//  Shared
//
//  Created by Lakr Aream on 2022/2/8.
//

import RayonModule
import SwiftUI

@main
struct RayonApp: App {
    @StateObject private var store = RayonStore.shared

    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    init() {
        RayonStore.setPresentError { error in
            UIBridge.presentError(with: error)
        }
        _ = RayonStore.shared
        NSLog("static main completed")
    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(store)
        }
        .windowToolbarStyle(.unifiedCompact)
        .commands {
            SidebarCommands()
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationShouldTerminate(_: NSApplication) -> NSApplication.TerminateReply {
        if RayonStore.shared.remoteSessions.count > 0 {
            UIBridge.requiresConfirmation(
                message: "One or more session is running, do you want to close them all?"
            ) { confirmed in
                guard confirmed else { return }
                for session in RayonStore.shared.remoteSessions {
                    RayonStore.shared.terminateSession(with: session.id)
                }
                NSApp.terminate(nil)
            }
            return .terminateCancel
        }
        return .terminateNow
    }
}
