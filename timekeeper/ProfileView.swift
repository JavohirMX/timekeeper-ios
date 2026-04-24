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
                    ProfileComponent(profile: usersProfile)
                }
                .foregroundStyle(.primary)
                Section {
                    ForEach(profiles.keys.sorted(), id: \.self) { name in
                        ProfileComponent(profile: profiles[name]!)
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
            AddProfileSheet(presentAddSheet: $presentAddSheet, profiles: $profiles)
        }

    }
}

#Preview {
    ProfileView()
        .preferredColorScheme(.dark)
}
