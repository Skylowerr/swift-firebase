//
//  SignInGoogleHelper.swift
//  FirebaseSecond
//
//  Created by Emirhan Gökçe on 24.02.2026.
//

import Foundation
import GoogleSignIn
import GoogleSignInSwift

//TODO: Neden initilialize etmiyoruz?
struct GoogleSignInResultModel{
    let idToken : String
    let accessToken : String
    let name : String?
    let email : String?
}


final class SignInGoogleHelper {
    
    @MainActor
    func signIn()async throws ->GoogleSignInResultModel{
        guard let topVC = Utilities.shared.topViewController() else{
            throw URLError(.cannotFindHost)
        }


        let gidSignInResult = try await  GIDSignIn.sharedInstance.signIn(withPresenting: topVC)

        guard let idToken = gidSignInResult.user.idToken?.tokenString else {throw URLError(.badURL)}

        let accessToken = gidSignInResult.user.accessToken.tokenString
        
        let name = gidSignInResult.user.profile?.name

        let email = gidSignInResult.user.profile?.email


        let token = GoogleSignInResultModel(idToken: idToken, accessToken: accessToken, name: name, email: email)
        return token
    }
    
}
