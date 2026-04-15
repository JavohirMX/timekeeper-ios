//
//  AlarmView.swift
//  timekeeper
//
//  Created by Javohir Muhammad and Ishandeep Singh on 15/04/26.
//

import SwiftUI

struct TimeAlarm: Identifiable {
    let id = UUID()
    let time: String
    var isOn: Bool
}

struct AlarmView: View {
    @State private var alarms: [TimeAlarm] = [
        TimeAlarm(time: "08.00", isOn: true),
        TimeAlarm(time: "14.00", isOn: false),
        TimeAlarm(time: "08.00", isOn: true),
        TimeAlarm(time: "14.00", isOn: false)
    ]
    @State private var toggleOn: Bool = true
    var body: some View {
        
        NavigationStack {
            List{
                Section {
                    HStack {
                        VStack (alignment: .leading) {
                            Text("07.00")
                                .font(.system(size: 60, weight: .light))
                            Text("Tomorrow Morning")
                        }
                        Spacer()
                        Button {
                            
                        } label: {
                            Text("CHANGE")
                                .foregroundStyle(.orange)
                                .padding(.vertical, 8)
                                .padding(.horizontal, 12)
                                .background(.gray.opacity(0.1))
                                .background(.ultraThinMaterial)
                                .cornerRadius(24)
                                .bold()
                        }
                    }
                } header: {
                    HStack {
                        Image(systemName: "bed.double.fill")
                        Text("Sleep | Wake Up")
                            .font(.title2)
                            .bold()
                    }
                    .foregroundStyle(.primary)
                }
                Section {
                    ForEach($alarms) {
                        $alarm in eachAlarm(time: alarm.time, toggle: $alarm.isOn)
                    }
                } header: {
                    Text("Other")
                        .font(.title2)
                        .bold()
                    Spacer()
                }
                .foregroundStyle(.primary)
            }
            .listStyle(.plain)
            .navigationBarTitle("Alarm")
            .toolbar {
                ToolbarItem (placement: .topBarLeading) {
                    EditButton()
                }
                ToolbarItem (placement: .topBarTrailing) {
                    Button("", systemImage: "plus") {}
                }
            }
        }
    }
}

func eachAlarm(time: String, toggle: Binding<Bool>) -> some View {
    VStack(alignment: .leading, spacing: 0){
            HStack(){
                Text(time)
                    .font(.system(size: 60, weight: .light))
                Spacer()
                Toggle("", isOn: toggle)
                    .toggleStyle(.switch)
                    .tint(.green)
            }
        Text("Alarm, everyday")
        }
}


#Preview {
    AlarmView()
        .preferredColorScheme(.dark)
}
