//
//  FriendView.swift
//  timekeeper
//
//  Created by Ishandeep Singh on 20/04/26.
//

import SwiftUI
import PhotosUI

struct ProfileView: View {
    @State private var profiles = defaultProfile
    @State private var usersProfile = userProfile[0]
    @State private var presentAddSheet = true
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var nickName = ""
    @State private var notes = ""
    @State private var selectedItem: PhotosPickerItem? = nil
    
    var body: some View {
        
        NavigationStack {
            List{
                Section {
                    ProfileComponent(profile: $usersProfile)
                }
//                header:{
//                    HStack {
//                        Image(systemName: "person.fill")
//                        Text("Me")
//                            .font(.title2)
//                            .bold()
//                    }
//                }
                .foregroundStyle(.primary)
                Section {
                    ForEach($profiles) { profile in
                        ProfileComponent(profile: profile)
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
                    Color(.secondarySystemBackground)
                    VStack {
                        //                        Button(action: {
                        //                            presentAddSheet.toggle()
                        //                            firstName = ""; lastName = "";
                        //                            nickName = ""; notes = "";
                        //                        }
                        Image("pfp2")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 244, height: 244)
                            .clipShape(Circle())
                        PhotosPicker(selection: $selectedItem, matching: .images) {
                            Text("Select Image")
                                .foregroundColor(.black)
                                .padding(.vertical, 12)
                                .padding(.horizontal, 28)
                                .background(.ultraThinMaterial)
                                .background(.gray.opacity(0.3))
                                .cornerRadius(24)
                                .font(.system(size: 16, weight: .bold))
                        }
                        .padding(.top, 16)
                        
                        List {
                            TextField("First Name", text: $firstName)
                            TextField("Last Name", text: $lastName)
                            TextField("Nick Name", text: $nickName)
                            TextField("Notes / Fun Fact", text: $notes)
                        }
                    }
                }
                
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button (action: {
                            presentAddSheet.toggle()
                            firstName = ""; lastName = "";
                            nickName = ""; notes = "";
                        })  {
                            Image(systemName: "xmark")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.primary)
                            .frame(width: 32, height: 32)
                            .clipShape(Circle())
                        }
                    }
                    
                    ToolbarItem(placement: .confirmationAction) {
                        Button {
                            presentAddSheet.toggle()
                            firstName = ""; lastName = "";
                            nickName = ""; notes = "";
                        } label: {
                            Image(systemName: "checkmark")
                                .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.primary)
                            .frame(width: 32, height: 32)
                            //.glassEffect(.regular.tint(.orange))
                            
                            
                        }
                            
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
