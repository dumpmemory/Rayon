//
//  mRayonApp.swift
//  mRayon
//
//  Created by Lakr Aream on 2022/3/2.
//

import RayonModule
import SwiftUI

@main
struct mRayonApp: App {
    @StateObject private var store = RayonStore.shared

    init() {
        #if DEBUG
            NSLog(CommandLine.arguments.joined(separator: "\n"))
        #endif
        RayonStore.setPresentError { error in
            UIBridge.presentError(with: error)
        }
        _ = RayonStore.shared
        NSLog("static main completed")
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(store)
        }
    }
}
