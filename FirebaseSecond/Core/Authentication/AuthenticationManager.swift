//
//  AuthenticationManager.swift
//  FirebaseSecond
//
//  Created by Emirhan Gökçe on 22.02.2026.
//

import Foundation
import FirebaseAuth

struct AuthDataResultModel{
    let uid : String
    let email : String?
    let photoURL : String?
    let isAnonymous : Bool //Sonradan googleını falan bağlamak isterse linklemek için lazım
    
    //MARK: AuthDataResultModel'i kullanırken dışarıdan user: girilmesini istiyoruz ve girilen değerleri buraya atıyoruz
    //Çünkü
    init(user: User){
        self.uid = user.uid
        self.email = user.email
        self.photoURL = user.photoURL?.absoluteString
        self.isAnonymous = user.isAnonymous
    }
}

enum AuthProviderOptions : String{
    case email = "password"
    case google = "google.com"
    //anonymous var bide
}


final class AuthenticationManager{
    static let shared = AuthenticationManager()
    
    private init(){} //MARK: Neden private: Bu durumda hafızada (RAM) iki farklı manager oluşur. Ancak biz kimlik doğrulama (Auth) işlemlerinin uygulama genelinde tek bir merkezden yönetilmesini istiyoruz. private init() ekleyerek, başkalarının () diyerek yeni bir manager üretmesini engelliyoruz.

    //MARK: Local olarak kullanıcıyı arıyor, o yüzden async kullanmıyoruz çünkü serverla işimiz yok.
    func getAuthenticatedUser() throws ->AuthDataResultModel{
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badURL)
        }
        return AuthDataResultModel(user: user)
    }
    
    func getProvider() throws -> [AuthProviderOptions] {
        guard let providerData = Auth.auth().currentUser?.providerData else{
            throw URLError(.badServerResponse)
        }
        
        var providers : [AuthProviderOptions] = []
        
        for provider in providerData{
            //TODO: rawValue: ne oluyor?
            //// provider.providerID "google.com" diye değer gelicek fakat biz onu .google olarak kullanıcaz
            if let option = AuthProviderOptions(rawValue: provider.providerID){
                providers.append(option)
            }else{
                //Özetle: assertionFailure, geliştiriciye (sana) "Hey Emirhan, yeni bir giriş yöntemi eklemişsin ama bunu enum içine yazmayı unutmuşsun!" diyen bir not defteri gibidir.
                assertionFailure("Provider option not found : \(provider.providerID)")
            }
        }
        
        return providers
    }

    
    //ÇIKIŞ YAP
    func signOut() throws {
        try Auth.auth().signOut()
    }
    
    
    func delete()async throws{
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badURL)
        }
        try await user.delete()
    }
}


//MARK: Sign In Email
extension AuthenticationManager{
    //KAYDOL
    @discardableResult //MARK: I know there is a result, but we might not out to use it
    func createUser(email : String, password: String) async throws -> AuthDataResultModel{
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    @discardableResult  //GİRİŞ YAP
    func signInUser(email : String, password: String) async throws -> AuthDataResultModel{
        let authDataResult = try await Auth.auth().signIn(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    
    func resetPassword(email : String) async throws{
        try await Auth.auth().sendPasswordReset(withEmail: email)
    }
    
    func updatePassword(password : String) async throws{
        guard let user = Auth.auth().currentUser else{
            throw URLError(.badURL)
        }
        
        try await user.updatePassword(to: password)
    }
    
    func updateEmail(email : String) async throws{
        guard let user = Auth.auth().currentUser else{
            throw URLError(.badURL)
        }
        
        try await user.updateEmail(to: email)
    }
}


//MARK: Sign In Google
extension AuthenticationManager{
    
    //MARK: Google ile giriş yapma kodu
    @discardableResult //TODO: Nedenine bak
    func signInWithGoogle(tokens : GoogleSignInResultModel) async throws -> AuthDataResultModel{
        let credential = GoogleAuthProvider.credential(withIDToken: tokens.idToken, accessToken: tokens.accessToken)
        return try await signIn(credential: credential)
    }
    
    //MARK: Genel Giriş Yapma Kodu
    func signIn(credential : AuthCredential) async throws -> AuthDataResultModel{
        let authDataResult = try await Auth.auth().signIn(with: credential)
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    
}

//MARK: Sign In Anonymous

extension AuthenticationManager{
    @discardableResult
    func signInAnonymous() async throws -> AuthDataResultModel{
        let authDataResult = try await Auth.auth().signInAnonymously()
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    func linkEmail(email : String, password : String) async throws -> AuthDataResultModel{
        //firebase docs
        let credential = EmailAuthProvider.credential(withEmail: email, password: password)
        return try await linkCredential(credential: credential)
    }
    
    func linkGoogle(tokens : GoogleSignInResultModel) async throws -> AuthDataResultModel{
        let credential = GoogleAuthProvider.credential(withIDToken: tokens.idToken, accessToken: tokens.accessToken)
        return try await signIn(credential: credential)
        
    }
    
    private func linkCredential(credential : AuthCredential)async throws -> AuthDataResultModel{
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badURL)
        }
        let authDataResult = try await user.link(with: credential)
        return AuthDataResultModel(user: authDataResult.user)
    }
    
}
