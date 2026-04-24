//
//  Scheduk=leSheet.swift
//  timekeeper
//
//  Created by Ishandeep Singh on 23/04/26.
//

import SwiftUI
import PhotosUI

struct AddProfileSheet: View {
    @State private var name = ""
    @State private var email = ""
    @State private var phone = ""
    @State private var selectedImage : Image? = nil
    @State private var selectedTimezone = TimeZone.current.identifier
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedIcon = "pfp2"
    @State private var profilesActivities: [Activity] = []
    @State private var presentScheduleSheet = false
    @Binding var presentAddSheet: Bool
    @Binding var profiles: [ProfileInfo]

    
    var body: some View {
        NavigationStack {
            ZStack{
                VStack {
                    if let selectedImage {
                        selectedImage
                            .resizable()
                            .scaledToFit()
                            .frame(width: 244, height: 244)
                            .clipShape(Circle())
                    } else {
                        Image("pfp2")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 244, height: 244)
                            .clipShape(Circle())
                    }
                    PhotosPicker(selection: $selectedItem, matching: .images) {
                        Text("Select Image")
                            .foregroundColor(.primary)
                            .padding(.vertical, 12)
                            .padding(.horizontal, 28)
                            .background(.regularMaterial)
                            .cornerRadius(24)
                    }
                    //to change image to slected image
                    .onChange(of: selectedItem) { _, newItem in
                        Task {
                            if let data = try? await newItem?.loadTransferable(type: Data.self),
                               let uiImage = UIImage(data: data) {
                                
                                selectedImage = Image(uiImage: uiImage)
                            }
                        }
                    }
                    .padding(.top, 16)
                    List {
                        Section{
                            HStack {
                                Text("Name")
                                TextField("Enter name", text: $name)
                                    .multilineTextAlignment(.trailing)
                            }
                            
                            HStack {
                                Text("Email")
                                TextField("Enter email", text: $email)
                                    .keyboardType(.emailAddress)
                                    .multilineTextAlignment(.trailing)
                            }
                            
                            HStack {
                                Text("Phone")
                                TextField("Enter phone", text: $phone)
                                    .keyboardType(.numberPad)
                                    .multilineTextAlignment(.trailing)
                            }
                            NavigationLink() {
                                TimezoneSheet(selectedTimezone: $selectedTimezone)
                            } label: {
                                HStack {
                                    Text("Timezone")
                                    Spacer()
                                    Text(formatTimezoneName(selectedTimezone))
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                        Section{
                            ForEach(profilesActivities) { activity in
                                HStack {
                                    Button {
                                        withAnimation {
                                            profilesActivities.removeAll { $0.id == activity.id }
                                        }
                                    } label: {
                                        Image(systemName: "minus.circle.fill").foregroundStyle(.red)
                                    }
                                    Image(systemName: activity.icon)
                                        .foregroundStyle(.orange)
                                    Text(activity.title)
                                    Spacer()
                                    HStack() {
                                        Image(systemName: "clock")
                                        Text(activity.startTime, style: .time)
                                        Text("-")
                                        Text(activity.endTime, style: .time)
                                    }
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                }
                            }
                            Button(action: { presentScheduleSheet.toggle() }) {
                                HStack {
                                    Image(systemName: "plus.circle.fill").foregroundStyle(.orange)
                                    Text("Add Schedule")
                                        .tint(.orange)
                                }
                            }
                        }
                        header: {
                            Text("Schedules")
                        }
                    }
                }
            }
            .navigationTitle("New Profile")
            .navigationBarTitleDisplayMode(.inline)
            
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button (action: {
                        presentAddSheet.toggle()
                        name = "";
                    })  {
                        Image(systemName: "xmark")
                            .foregroundColor(.primary)
                            .clipShape(Circle())
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        let newProfile = ProfileInfo(name: name, imageName: "person.crop.circle", email: email, phNum: phone, timezoneIdentifier: selectedTimezone, schedules: profilesActivities)
                        profiles.append(newProfile)
                        presentAddSheet.toggle()
                    } label: {
                        Image(systemName: "checkmark")
                            .foregroundColor(.primary)
                        
                        
                        
                    }.buttonStyle(.borderedProminent)
                        .tint(.orange)
                        .disabled(name.isEmpty)
                    
                }
            }
        }
        .sheet(isPresented: $presentScheduleSheet) {
                ScheduleSheet(presentSheet: $presentScheduleSheet, schedule: $profilesActivities)
            
        }
    }
}

