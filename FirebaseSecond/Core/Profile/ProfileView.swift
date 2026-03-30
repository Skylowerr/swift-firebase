//
//  ProfileView.swift
//  FirebaseSecond
//
//  Created by Emirhan Gökçe on 27.02.2026.
//

import SwiftUI

@MainActor
@Observable
final class ProfileViewModel{
    private(set) var user: DBUser? = nil
    
    func loadCurrentUser() async throws{
        let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser()
        
        self.user = try await UserManager.shared.getUser(userId: authDataResult.uid)
    }
}

struct ProfileView: View {
    @State private var viewModel = ProfileViewModel()
    @Binding var showSignInView : Bool
    var body: some View {
        List{
            if let user = viewModel.user{
                Text("UserId : \(user.userId)")
                
                if let isAnonymous = user.isAnonymous{
                    Text("Is Anonymous : \(isAnonymous.description.capitalized)")
                }
            }
        }
        .task{
            do{
                try await viewModel.loadCurrentUser()
            }catch{
                print("loadCurrentUser error:", error)
            }
        }
        
        .navigationTitle("Profile")
        .toolbar{
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink {
                    SettingsView(showSignInView: $showSignInView)
                } label: {
                    Image(systemName: "gear")
                        .font(.headline)
                }

            }
        }
        
    }
}

#Preview {
    ProfileView(showSignInView: .constant(false))
}
