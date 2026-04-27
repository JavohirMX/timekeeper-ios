//
//  timekeeperApp.swift
//  timekeeper
//
//  Created by Javohir Muhammad on 15/04/26.
//

import SwiftUI
import SwiftData

@main
struct timekeeperApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [ProfileInfo.self, Activity.self])
    }
}
