//
//  SignInEmailView.swift
//  FirebaseSecond
//
//  Created by Emirhan Gökçe on 22.02.2026.
//

import SwiftUI
internal import Combine



struct SignInEmailView: View {
    @State private var viewModel = SignInEmailViewModel()
    @Binding var showSignInView : Bool
    var body: some View {
        VStack{
            TextField("Email", text: $viewModel.email)
                .autocorrectionDisabled()
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never) //// Otomatik büyük harfi kapatır
                .padding()
                .background(Color(.systemGray6))
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            SecureField("Password", text: $viewModel.password)
                .padding()
                .background(Color(.systemGray6))
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            Button {
                //TODO: async throws olmadığı için Button'da Task{try await} şeklinde yazarız
                
                //Önce kaydolmayı dener.?
                Task{
                    do{
                        try await viewModel.signUp()
                        showSignInView = false
                        return
                    }catch{
                        print(error) //Email kullanımdaysa buraya girer. Buradan da diğer do-catch bloğuna girer
                    }
                    
                    //Yoksa giriş yapar
                    do{
                        try await viewModel.signIn()
                        showSignInView = false
                        return
                    }catch{
                        print(error)
                    }
                }
                
            } label: {
                Text("Sign In")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            
            Spacer()

        }
        
        .padding()
        .navigationTitle("Sign In With Email")
    }
}

#Preview {
    NavigationStack {
        SignInEmailView(showSignInView: .constant(false))
    }
}
