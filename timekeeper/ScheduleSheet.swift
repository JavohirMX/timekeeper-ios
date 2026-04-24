//
//  Scheduk=leSheet.swift
//  timekeeper
//
//  Created by Ishandeep Singh on 23/04/26.
//

import SwiftUI

struct ScheduleSheet: View {
    @State private var title = ""
    @State private var icon = "house"
    @State private var startTime = Date()
    @State private var endTime = Date()
    @Binding var presentSheet: Bool
    @Binding var schedule: [Activity]
    
    var body: some View {
        NavigationStack {
            List {
                Section{
                    TextField("Title", text: $title)
                }
                Section{
                    Picker("Icon", selection: $icon) {
                        Label("Home", systemImage: "house").tag("house")
                        Label("Work", systemImage: "briefcase").tag("briefcase")
                        Label("Social", systemImage: "person.2").tag("person.2")
                        Label("Sleep", systemImage: "moon").tag("moon")
                        Label("Workout", systemImage: "dumbbell").tag("dumbbell")
                        Label("Study", systemImage: "book").tag("book")
                        Label("Computer", systemImage: "laptopcomputer").tag("laptopcomputer")
                        Label("Shopping", systemImage: "cart").tag("cart")
                        Label("Food", systemImage: "fork.knife").tag("fork.knife")
                        Label("Money", systemImage: "dollarsign").tag("dollarsign")
                        Label("Gaming", systemImage: "gamecontroller").tag("gamecontroller")
                        Label("Travel", systemImage: "airplane").tag("airplane")
                        Label("Important", systemImage: "star").tag("star")
                    }
                    .pickerStyle(.menu)
                    .tint(.orange)
                    
                    DatePicker(
                        "Starts",
                        selection: $startTime,
                        displayedComponents: [.hourAndMinute]
                    )
                    DatePicker(
                        "Ends",
                        selection: $endTime,
                        displayedComponents: [.hourAndMinute]
                    )
                }
            }
            .navigationTitle("New Schedule")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button (action: {presentSheet.toggle()})  {
                        Image(systemName: "xmark")
                        .foregroundColor(.primary)
                        .clipShape(Circle())
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        let newActivity = Activity(title: title, icon: icon, startTime: startTime, endTime: endTime)
                        schedule.append(newActivity)
                        presentSheet.toggle()
                    } label: {
                        Image(systemName: "checkmark")
                        .foregroundColor(.primary)

                        
                        
                    }.buttonStyle(.borderedProminent)
                        .tint(.orange)
                        .disabled(title.isEmpty)
                        
                }
            }
        }
    }
}

