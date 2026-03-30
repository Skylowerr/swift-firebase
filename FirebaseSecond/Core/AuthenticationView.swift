//
//  AuthenticationView.swift
//  FirebaseSecond
//
//  Created by Emirhan Gökçe on 22.02.2026.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift




struct AuthenticationView: View {
    @Binding var showSignInView : Bool
    @State private var viewModel = AuthenticationViewModel()
    
    var body: some View {
        VStack{
            //TODO: Bak! Neden Button, neden Task, neden NavigationLink değil?
            Button {
                Task{
                    do{
                        try await viewModel.signInAnonymous()
                        showSignInView = false
                    }catch{
                        print(error)
                    }
                }
            } label: {
                Text("Sign In Anonymously")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(.orange)
                    .clipShape(RoundedRectangle(cornerRadius: 10))

            }

            
            
            NavigationLink {
                SignInEmailView(showSignInView: $showSignInView)
            } label: {
                Text("Sign In With Email")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            
            GoogleSignInButton(viewModel: GoogleSignInButtonViewModel(scheme: .dark, style: .wide, state: .normal)) {
                Task{
                    do{
                        try await viewModel.signIngoogle()
                        showSignInView = false //dismiss the screen
                    }catch{
                        print(error)
                    }
                }
            }
            
            Spacer()

        }
        .padding()
        .navigationTitle("Sign In")
    }
}

#Preview {
    NavigationStack {
        AuthenticationView(showSignInView: .constant(false))
    }
}
