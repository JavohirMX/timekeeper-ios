//
//  FriendView.swift
//  timekeeper
//
//  Created by Ishandeep Singh on 20/04/26.
//

import SwiftUI
import PhotosUI
import SwiftData

struct ProfileView: View {
    @Query(filter: #Predicate<ProfileInfo> { $0.isMainUser == true }) var mainUsers: [ProfileInfo]
    @Query(filter: #Predicate<ProfileInfo> { $0.isMainUser == false }, sort: \ProfileInfo.name) var connections: [ProfileInfo]
    @Environment(\.modelContext) private var context
    @State private var presentAddSheet = false
    @State private var creatingMainUser = false
    
    var body: some View {
        
        NavigationStack {
            List{
                Section {
                    if let myProfile = mainUsers.first {
                        ProfileComponent(profile: myProfile, isMainUser: true)
                    } else {
                        Button {
                            creatingMainUser = true
                            presentAddSheet.toggle()
                        } label: {
                            HStack {
                                Image(systemName: "person.crop.circle.badge.plus")
                                Text("Set Up My Profile")
                            }
                            .foregroundColor(.orange)
                        }
                    }
                }
                Section {
                    ForEach(connections) { profile in
                        ProfileComponent(profile: profile, isMainUser: false)
                    }
                    //swipe to delete
                    .onDelete { indexSet in
                        for index in indexSet {
                            context.delete(connections[index])
                        }
                    }
                }header: {
                    Text("Connections").font(.title2).bold()
                    
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Profiles")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        creatingMainUser = false
                        presentAddSheet.toggle()
                    }) {
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
            AddProfileSheet(isMainUser: $creatingMainUser, presentAddSheet: $presentAddSheet)
            }        

    }
}

#Preview {
    ProfileView()
        .preferredColorScheme(.dark)
}
