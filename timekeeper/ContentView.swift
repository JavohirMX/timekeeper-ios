//
//  ContentView.swift
//  timekeeper
//
//  Created by Javohir Muhammad on 15/04/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {

            Tab("Schedule", systemImage: "clock.circle.fill") {
                ScheduleView()
            }
            Tab("Profiles", systemImage: "person.2") {
                ProfileView()
            }
        }
        .tint(.orange)
    }
}

#Preview {
    ContentView().preferredColorScheme(.dark)
}

