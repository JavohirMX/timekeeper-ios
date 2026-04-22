//
//  ContentView.swift
//  timekeeper
//
//  Created by Javohir Muhammad and Ishandeep Singh on 15/04/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Tab("Schedule", systemImage: "timer.circle") {
            }
            Tab("Alarm", systemImage: "alarm") {
                AlarmView()
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

