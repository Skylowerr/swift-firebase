//
//  UserManager.swift
//  FirebaseSecond
//
//  Created by Emirhan Gökçe on 27.02.2026.
//

import Foundation
import FirebaseFirestore
import Firebase


struct DBUser{
    let userId : String
    let isAnonymous : Bool?
    let email : String?
    let photoUrl : String?
    let dateCreated : Date?
}


//MARK: Firestore Notları
final class UserManager{
    static let shared = UserManager()
    private init(){}
    func createNewUser(auth: AuthDataResultModel) async throws{
        var userData : [String : Any] = [
            "user_id" : auth.uid,
            "is_anonymous" : auth.isAnonymous,
            "date_created" : Timestamp(),
        ]
        if let email = auth.email{
            userData["email"] = email
        }
        
        if let photoUrl = auth.photoURL{
            userData["photo_url"] = photoUrl
        }
        
        try await Firestore.firestore().collection("users").document(auth.uid).setData(userData, merge: false)
    }
    
    func getUser(userId : String) async throws -> DBUser{
        let snapshot = try await Firestore.firestore().collection("users").document(userId).getDocument()
        
        guard let data = snapshot.data(), let userId = data["user_id"] as? String else {
            throw URLError(.badURL)
        }
        
        let isAnonymous = data["is_anonymous"] as? Bool
        let email = data["email"] as? String
        let photoUrl = data["photo_url"] as? String
        let dateCreated = data["date_created"] as? Date //Timestamp olmasına rağmen date kullanabiliyoruz
        
        return DBUser(userId: userId, isAnonymous: isAnonymous, email: email, photoUrl: photoUrl, dateCreated: dateCreated)
        
    
    }
    
    
    
}
