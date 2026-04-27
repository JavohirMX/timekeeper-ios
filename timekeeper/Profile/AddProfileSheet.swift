//
//  Scheduk=leSheet.swift
//  timekeeper
//
//  Created by Ishandeep Singh on 23/04/26.
//

import SwiftUI
import PhotosUI

struct AddProfileSheet: View {
    var existingProfile: ProfileInfo? = nil
    @State private var selectedImage : Image? = nil
    @State private var selectedItem: PhotosPickerItem? = nil
    
    @State private var profile = ProfileInfo(
        name: "",
        imageName: "pfp2",
        email: "",
        phNum: "",
        timezoneIdentifier: TimeZone.current.identifier,
        schedules: []
    )
    
    @State private var presentScheduleSheet = false
    @Binding var presentAddSheet: Bool
    @Binding var profiles: [String: ProfileInfo]

    
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
                        Image(profile.imageName)
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
                                TextField("Enter name", text: $profile.name)
                                    .multilineTextAlignment(.trailing)
                            }
                            
                            HStack {
                                Text("Email")
                                TextField("Enter email", text: $profile.email)
                                    .keyboardType(.emailAddress)
                                    .multilineTextAlignment(.trailing)
                            }
                            
                            HStack {
                                Text("Phone")
                                TextField("Enter phone", text: $profile.phNum)
                                    .keyboardType(.numberPad)
                                    .multilineTextAlignment(.trailing)
                            }
                            NavigationLink() {
                                TimezoneSheet(selectedTimezone: $profile.timezoneIdentifier)
                            } label: {
                                HStack {
                                    Text("Timezone")
                                    Spacer()
                                    Text(formatTimezoneName(profile.timezoneIdentifier))
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                        Section{
                            ForEach(profile.schedules) { activity in
                                HStack {
                                    Button {
                                        withAnimation {
                                            profile.schedules.removeAll { $0.id == activity.id }
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
            .navigationTitle(existingProfile == nil ? "New Profile" : "Edit Profile") //change title depending if there is  existingProfile
            .navigationBarTitleDisplayMode(.inline)
            
            // load data when view opens
            .onAppear {
                if let existing = existingProfile {
                    profile = existing
                }
            }
            
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button (action: {
                        presentAddSheet.toggle()
                    })  {
                        Image(systemName: "xmark")
                            .foregroundColor(.primary)
                            .clipShape(Circle())
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        //if user changes name while editing, delete  old dictionary key
                        if let existing = existingProfile, existing.name != profile.name {
                            profiles.removeValue(forKey: existing.name)
                        }
                        
                        profiles[profile.name] = profile
                        presentAddSheet.toggle()
                    } label: {
                        Image(systemName: "checkmark")
                            .foregroundColor(.primary)
                        
                        
                        
                    }.buttonStyle(.borderedProminent)
                        .tint(.orange)
                        .disabled(profile.name.isEmpty)
                    
                }
            }
        }
        .sheet(isPresented: $presentScheduleSheet) {
                ScheduleSheet(presentSheet: $presentScheduleSheet, schedule: $profile.schedules)
            
        }
    }
}

