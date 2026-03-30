//
//  AuthenticationViewModel.swift
//  FirebaseSecond
//
//  Created by Emirhan Gökçe on 27.02.2026.
//

import Foundation
//MARK: Eğer bu verileri Manager içine koyarsan, uygulama genelindeki her yer bu veriden etkilenir. Ama ViewModel her ekrana özeldir.
@MainActor
@Observable
final class AuthenticationViewModel{
    
    func signIngoogle() async throws{
        let helper = SignInGoogleHelper()
        let tokens = try await helper.signIn()
        let authDataResult = try await AuthenticationManager.shared.signInWithGoogle(tokens: tokens)
        try await UserManager.shared.createNewUser(auth: authDataResult)

    }
    
    func signInAnonymous() async throws{
        let authDataResult = try await AuthenticationManager.shared.signInAnonymous()
        try await UserManager.shared.createNewUser(auth: authDataResult)
    }
    
}
