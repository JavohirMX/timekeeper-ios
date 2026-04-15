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
            Tab("World Clock", systemImage: "globe") {
                
            }
            Tab("Alarm", systemImage: "alarm") {
                AlarmView()
            }
            Tab("Stopwatch", systemImage: "stopwatch") {
                
            }
            Tab("Timers", systemImage: "timer") {
                
            }
        }
        .tint(.orange)
    }
}

#Preview {
    ContentView().preferredColorScheme(.dark)
}

