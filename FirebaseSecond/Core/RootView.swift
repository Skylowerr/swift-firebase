//
//  RootView.swift
//  FirebaseSecond
//
//  Created by Emirhan Gökçe on 23.02.2026.
//

import SwiftUI

struct RootView: View {
    @State private var showSignInView : Bool = false
    
    var body: some View {
        ZStack{
            if !showSignInView{
                NavigationStack{
                    ProfileView(showSignInView: $showSignInView)
                }
            }
            
        }
        //TODO: Giriş yapılmış mı kontrolü?
        .onAppear{
            let authUser = try? AuthenticationManager.shared.getAuthenticatedUser()
            self.showSignInView = authUser == nil //Eğer kullanıcı yoksa giriş ekranı açılır
            
        }
        
        //showSignInView değeri false olduğu an, .fullScreenCover otomatik olarak kendini kapatır
        .fullScreenCover(isPresented: $showSignInView) {
            NavigationStack{
                AuthenticationView(showSignInView: $showSignInView)
            }
        }
    }
}

#Preview {
    RootView()
}
