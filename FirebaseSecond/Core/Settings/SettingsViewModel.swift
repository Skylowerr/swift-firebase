//
//  SettingsViewModel.swift
//  FirebaseSecond
//
//  Created by Emirhan Gökçe on 27.02.2026.
//

import Foundation
import Observation // Yeni framework

@Observable
@MainActor
final class SettingsViewModel{ //MARK: : ObservableObject gerekebilir
    
    var authProviders : [AuthProviderOptions] = []
    var authUser : AuthDataResultModel? = nil
    
    func loadAuthProviders(){
        if let providers = try? AuthenticationManager.shared.getProvider(){
            authProviders = providers
        }
    }
    
    func loadAuthUser(){
        self.authUser = try? AuthenticationManager.shared.getAuthenticatedUser()
    }
    
    func signOut() throws{
        try AuthenticationManager.shared.signOut()
    }
    
    func resetPassword()async throws{
        let currentUser = try AuthenticationManager.shared.getAuthenticatedUser()
        guard let email = currentUser.email else {
            throw URLError(.fileDoesNotExist)
        }
        
        try await AuthenticationManager.shared.resetPassword(email: email)
    }
    
    func updateEmail() async throws{
        let email = "hellosky@gmail.com" //yeni email
        try await AuthenticationManager.shared.updateEmail(email: email)
    }
    
    func updatePassword() async throws{
        let password = "hello123" //yeni şifremiz
        try await AuthenticationManager.shared.updatePassword(password: password)
    }
    
    func linkGoogleAccount()async throws{
        let helper = SignInGoogleHelper()
        let tokens = try await helper.signIn()
        self.authUser = try await AuthenticationManager.shared.linkGoogle(tokens: tokens)
        
    }
    
    func linkEmailAccount()async throws{
        let email = "another123@gmail.com"
        let password = "Hello123!"
        self.authUser = try await AuthenticationManager.shared.linkEmail(email: email, password: password)
    }
    
    func deleteAccount() async throws{
        try await AuthenticationManager.shared.delete()
    }
    
}
