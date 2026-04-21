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
            Tab("Schedule", systemImage: "clock.circle.fill") {
                ScheduleView()
            }
            Tab("People", systemImage: "person.3.fill") {
                AlarmView()
            }
        }
        .tint(.orange)
    }
}

#Preview {
    ContentView().preferredColorScheme(.dark)
}

