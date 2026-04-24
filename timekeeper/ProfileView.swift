//
//  FriendView.swift
//  timekeeper
//
//  Created by Ishandeep Singh on 20/04/26.
//

import SwiftUI
import PhotosUI

struct ProfileView: View {
    private var profiles = defaultProfiles
    private var usersProfile = userProfile[0]
    @State private var presentAddSheet = true
    @State private var presentTimezoneSheet = false
    @State private var name = ""
    @State private var email = ""
    @State private var phone = ""
    @State private var selectedTimezone = TimeZone.current.identifier
    @State private var selectedItem: PhotosPickerItem? = nil
    
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
            NavigationStack {
                ZStack{
                    VStack {
                        Image("pfp2")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 244, height: 244)
                            .clipShape(Circle())
                        PhotosPicker(selection: $selectedItem, matching: .images) {
                            Text("Select Image")
                                .foregroundColor(.primary)
                                .padding(.vertical, 12)
                                .padding(.horizontal, 28)
                                .background(.regularMaterial)
                                .cornerRadius(24)
                        }
                        .padding(.top, 16)
                        List {
                            HStack {
                                Text("Name")
                                TextField("Enter name", text: $name)
                                    .multilineTextAlignment(.trailing)
                            }
                            
                            HStack {
                                Text("Email")
                                TextField("Enter email", text: $email)
                                    .multilineTextAlignment(.trailing)
                            }
                            
                            HStack {
                                Text("Phone")
                                TextField("Enter phone", text: $phone)
                                    .multilineTextAlignment(.trailing)
                            }
                            HStack {
                                Text("Timezone")
                                Spacer()
                                Text("Asia/Jakarta")
                                    .foregroundColor(.secondary)
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.secondary)
                                    .font(.caption)
                            }
                            .contentShape(Rectangle())
                            .onTapGesture {
                                presentTimezoneSheet = true
                            }
                            
                        }
                    }
                }
                
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
                            presentAddSheet.toggle()
                            name = "";
                        } label: {
                            Image(systemName: "checkmark")
                            .foregroundColor(.primary)

                            
                            
                        }.buttonStyle(.borderedProminent)
                            .tint(.orange)
                            
                    }
                }
            }
        }
        
    }
}

#Preview {
    ProfileView()
        .preferredColorScheme(.dark)
}
