//
//  SignInScreenView.swift
//  Saffron
//
//  Created by Ngozi Amaefule on 2/2/22.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift


struct SignInScreenView: View {
    @State var email = ""
    @State var password = ""
    
    @EnvironmentObject var viewModel: AppViewModel
    var body: some View {
        ZStack {
            Image(uiImage: #imageLiteral(resourceName: "Saffron2.jpeg"))
                .resizable()
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                
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
                    viewModel.signIn(email: email, password: password)
                } label: {
                    Text("Sign In")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .padding()
                        .background(Color.orange)
                        .cornerRadius(50.0)
                        .shadow(color: Color.black.opacity(0.88), radius: 60, x: 0.0, y: 16)
                        .padding(.vertical)
                }
                
                Spacer()
                
            }
            .navigationTitle("Sign In")
        }
    }
}



struct SignInScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SignInScreenView()
    }
}

//}
