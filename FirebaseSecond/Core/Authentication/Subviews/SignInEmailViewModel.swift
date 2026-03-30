//
//  SignInEmailViewModel.swift
//  FirebaseSecond
//
//  Created by Emirhan Gökçe on 27.02.2026.
//

import Foundation
@MainActor
@Observable
final class SignInEmailViewModel  {
    
     var email = ""
     var password = ""
    
    //KAYDOL
    func signUp() async throws{
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found")
            return
        }
        
        //discardable old. için bir şey yazmaya gerek yok.Bu değeri kullanmayacağız
        let authDataResult = try await AuthenticationManager.shared.createUser(email: email, password: password)
        try await UserManager.shared.createNewUser(auth: authDataResult)
        
    }
    
    //GİRİŞ YAP
    
    func signIn() async throws{
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found")
            return
        }
        
        //discardable old. için bir şey yazmaya gerek yok.Bu değeri kullanmayacağız
        try await AuthenticationManager.shared.signInUser(email: email, password: password)
    }
    

    
    
}
