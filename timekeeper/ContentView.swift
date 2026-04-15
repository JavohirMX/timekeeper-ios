//
//  ContentView.swift
//  timekeeper
//
//  Created by Javohir Muhammad and Ishandeep Singh on 15/04/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List{
                VStack(alignment: .leading, spacing: 0){
                    HStack(){
                        Image(systemName: "bed.double.fill")
                        Text("Sleep | Wake Up").font(.title2) .bold(true)
                    }
                    HStack(){
                        VStack(alignment: .leading){
                            Text("07.00")
                                .font(.system(size: 60, weight: .light))
                            
                            Text("Tomorrow Morning")
                        }
                        Spacer()
                        Button{} label: {
                            Text("CHANGE")
                                .foregroundColor(.orange)
                                .padding(.vertical, 8)
                                .padding(.horizontal, 12)
                                .background(.ultraThinMaterial)
                                .background(.gray.opacity(0.1))
                                .cornerRadius(24)
                                .font(.system(size: 16, weight: .bold))
                        }
                    }
                }
                
                VStack(alignment: .leading, spacing: 0){
                    HStack(){
                        Text("Other").font(.title2) .bold(true)
                    }
                    eachAlarm(time: "08.00", toggle: true)
                    eachAlarm(time: "14.00", toggle: false)
                    eachAlarm(time: "08.00", toggle: false)
                    eachAlarm(time: "14.00", toggle: true)
                    
                }
            }.listStyle(.plain)
        }
        
        TabView{
            Tab("World Clock", systemImage: "globe"){
            }
            Tab("Alarms", systemImage: "alarm"){
            }
            Tab("Stopwatch", systemImage: "stopwatch"){
            }
            Tab("Timers", systemImage: "timer"){
            }
        }.tint(.orange)
    }
}

func eachAlarm(time: String, toggle: Bool) -> some View {
    VStack(alignment: .leading, spacing: 0){
            HStack(){
                Text(time)
                    .font(.system(size: 60, weight: .light))
                Spacer()
                Toggle("", isOn: .constant(toggle))
            }
        Text("Alarm, everyday")
        }
}

#Preview {
    ContentView()
        .preferredColorScheme(.dark)
}
