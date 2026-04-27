//
//  FriendView.swift
//  timekeeper
//
//  Created by Ishandeep Singh on 20/04/26.
//

import SwiftUI
import PhotosUI

struct ProfileView: View {
    @State private var profiles = defaultProfiles
    @State private var usersProfile = userProfile[0]
    @State private var presentAddSheet = false
    
    var body: some View {
        
        NavigationStack {
            List{
                Section {
                    ProfileComponent(profile: usersProfile, profiles: $profiles, usersProfile: $usersProfile, isMainUser: true)
                }
                .foregroundStyle(.primary)
                Section {
                    ForEach(profiles.keys.sorted(), id: \.self) { name in
                        ProfileComponent(profile: profiles[name]!, profiles: $profiles, usersProfile: $usersProfile, isMainUser: false)
                        
                    }
                    //swipe to delete
                    .onDelete { indexSet in
                        let sortedKeys = profiles.keys.sorted()
                        for index in indexSet {
                            profiles.removeValue(forKey: sortedKeys[index])
                        }
                    }
                }header: {
                    Text("Connections")
                        .font(.title2)
                        .bold()
                    
                }
                .foregroundStyle(.primary)
                
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Profiles")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: { presentAddSheet.toggle() }) {
                        Image(systemName: "plus")
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    EditButton()
                }
            }
            .tint(.orange)
        }
        .sheet(isPresented: $presentAddSheet) {
            AddProfileSheet(presentAddSheet: $presentAddSheet, profiles: $profiles, usersProfile: $usersProfile)
        }

    }
}

#Preview {
    ProfileView()
        .preferredColorScheme(.dark)
}
