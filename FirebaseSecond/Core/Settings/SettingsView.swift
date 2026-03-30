//
//  SettingsView.swift
//  FirebaseSecond
//
//  Created by Emirhan Gökçe on 23.02.2026.
//

import SwiftUI

struct SettingsView: View {
    @State private var viewModel = SettingsViewModel() //MARK: StateObject gerekebilir
    @Binding var showSignInView : Bool
    @State private var showDeleteConfirmation = false
    
    var body: some View {
        List{
            Button("Log Out"){
                Task{
                    do{
                        try viewModel.signOut()
                        showSignInView = true
                    }catch{
                        print(error)
                    }
                }
            }
            
            Button(role: .destructive) {
                showDeleteConfirmation = true
            } label: {
                Text("Delete Account")
            }
            .alert("Delete Account", isPresented: $showDeleteConfirmation) {
                Button("Cancel", role: .cancel) {}
                Button("Delete", role: .destructive) {
                    Task {
                        do {
                            try await viewModel.deleteAccount()
                            showSignInView = true
                        } catch {
                            print(error)
                        }
                    }
                }
            } message: {
                Text("This action will permanently delete your account and all associated data. Are you sure you want to continue?")
            }

            
            if viewModel.authProviders.contains(.email){
                emailSection
            }
            
            //anonymousSection hariç 2 parantezi kaldırman gerkeebilri
            if viewModel.authUser?.isAnonymous == true{
                anonymousSection
            }
            
        }
        
        .onAppear{
            viewModel.loadAuthProviders()
            viewModel.loadAuthUser()
        }
        .navigationTitle("Settings")
    }
}

#Preview {
    NavigationStack {
        SettingsView(showSignInView: .constant(false))
    }
}

extension SettingsView{
    private var emailSection : some View{
        Section("Email Functions"){
            Button("Reset Password"){
                Task{
                    do{
                        try await viewModel.resetPassword()
                        print("PASSWORD RESET")
                    }catch{
                        print(error)
                    }
                }
            }
            
            Button("Update Email"){
                Task{
                    do{
                        try await viewModel.updateEmail()
                        print("EMAIL UPDATED")
                    }catch{
                        print(error)
                    }
                }
            }
            
            Button("Update Password"){
                Task{
                    do{
                        try await viewModel.updatePassword()
                        print("PASSWORD UPDATED")
                    }catch{
                        print(error)
                    }
                }
            }
        }
        
        
        

    }
    
    private var anonymousSection : some View{
        Section{
            Button("Link Google Account"){
                Task{
                    do{
                        try await viewModel.linkGoogleAccount()
                        print("GOOGLE LINKED")
                    }catch{
                        print(error)
                    }
                }
            }
            
            Button("Link Email Account"){
                Task{
                    do{
                        try await viewModel.linkEmailAccount()
                        print("EMAIL LINKED")
                    }catch{
                        print(error)
                    }
                }
            }
            
        }

    }
}

