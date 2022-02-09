//
//  SignUpScreenView.swift
//  Saffron
//
//  Created by Ngozi Amaefule on 2/8/22.
//
import Foundation
import SwiftUI

struct SignUpScreenView: View {
    @State var email = ""
    @State var password = ""
    
    @State private var showSignIn = false
    
    @EnvironmentObject var viewModel: AppViewModel
    var body: some View {
        ZStack {
            Image(uiImage: #imageLiteral(resourceName: "Saffron2.jpeg"))
                .resizable()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                VStack {
                    TextField("Email address", text: $email)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .font(.title3)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(50.0)
                        .shadow(color: Color.black.opacity(0.88), radius: 60, x: 0.0, y: 16)
                        .padding(.vertical)
                    
                    SecureField("Password", text: $password)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .font(.title3)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(50.0)
                        .shadow(color: Color.black.opacity(0.88), radius: 60, x: 0.0, y: 16)
                        .padding(.vertical)
                }
                .padding()
                
                Button {
                    guard !email.isEmpty, !password.isEmpty else {
                        return
                    }
                    viewModel.signUp(email: email, password: password)
                    showSignIn.toggle()
                } label: {
                    Text("Create Account")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .padding()
                        .background(Color.orange)
                        .cornerRadius(50.0)
                        .shadow(color: Color.black.opacity(0.88), radius: 60, x: 0.0, y: 16)
                        .padding(.vertical)
                }
            }
            .navigationTitle("Sign Up")
        }
    }
}
