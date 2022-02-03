//
//  SignInScreenView.swift
//  Saffron
//
//  Created by Ngozi Amaefule on 2/2/22.
//

import SwiftUI
import FirebaseAuth

class AppViewModel: ObservableObject {
    
    let auth = Auth.auth()
    
    @Published var signedIn = false
    
    var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    
    func signIn(email: String, password: String) {
        auth.signIn(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                // Success
                self?.signedIn = true
            }
        }
    }
    
    func signUp(email: String, password: String) {
        auth.createUser(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                // Success
                self?.signedIn = true
            }
        }
    }
}


struct SignInScreenView: View {
    @State var email = ""
    @State var password = ""
    
    @EnvironmentObject var viewModel: AppViewModel
    var body: some View {
        //        WelcomeScreenView()
        
        //    @State private var email: String = "" // by default it's empty
        //    var body: some View {
        ZStack {
            Image(uiImage: #imageLiteral(resourceName: "Saffron2.jpeg"))
                .resizable()
                .edgesIgnoringSafeArea(.all)
            //                .scaledToFill()
            
            VStack {
                VStack {
//                    Text("Sign In")
//                        .font(.largeTitle)
//                        .fontWeight(.bold)
//                        .foregroundColor(Color.white)
                    
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
                
                NavigationLink(destination: RecipeCategoryListScreen(), label: {
                    Text("Sign In")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .padding()
                        .background(Color.orange)
                        .cornerRadius(50.0)
                        .shadow(color: Color.black.opacity(0.88), radius: 60, x: 0.0, y: 16)
                        .padding(.vertical)
                })
                
                //                Button {
                //                    guard !email.isEmpty, !password.isEmpty else {
                //                        return
                //                    }
                //                    viewModel.signIn(email: email, password: password)
                //                } label: {
                //                    Text("Sign In")
                //                        .font(.title3)
                //                        .fontWeight(.bold)
                //                        .foregroundColor(Color.white)
                //                        .padding()
                //                        .background(Color.orange)
                //                        .cornerRadius(50.0)
                //                        .shadow(color: Color.black.opacity(0.88), radius: 60, x: 0.0, y: 16)
                //                        .padding(.vertical)
                //                }
                
//                Spacer()
                
            }
            .navigationTitle("Sign In")
        }
        //        .onAppear {
        //            viewModel.signedIn = viewModel.isSignedIn
        //        }
    }
}

struct SignUpScreenView: View {
    @State var email = ""
    @State var password = ""
    
    @EnvironmentObject var viewModel: AppViewModel
    var body: some View {
        //        WelcomeScreenView()
        
        //    @State private var email: String = "" // by default it's empty
        //    var body: some View {
        //        NavigationView {
        ZStack {
            Image(uiImage: #imageLiteral(resourceName: "Saffron2.jpeg"))
                .resizable()
                .edgesIgnoringSafeArea(.all)
            //                .scaledToFill()
            
            VStack {
//                Text("Create Account")
//                    .font(.largeTitle)
//                    .fontWeight(.bold)
//                    .foregroundColor(Color.white)
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
                
//                Button {
//                    guard !email.isEmpty, !password.isEmpty else {
//                        return
//                    }
//                    viewModel.signUp(email: email, password: password)
//                } label: {
//                    Text("Create Account")
//                        .font(.title3)
//                        .fontWeight(.bold)
//                        .foregroundColor(Color.white)
//                        .padding()
//                        .background(Color.orange)
//                        .cornerRadius(50.0)
//                        .shadow(color: Color.black.opacity(0.88), radius: 60, x: 0.0, y: 16)
//                        .padding(.vertical)
//                }
                
//                Spacer()
                
                
                NavigationLink(destination: SignInScreenView(), label: {
                    Text("Create Account")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .padding()
                        .background(Color.orange)
                        .cornerRadius(50.0)
                        .shadow(color: Color.black.opacity(0.88), radius: 60, x: 0.0, y: 16)
                        .padding(.vertical)
                })
            }
            .navigationTitle("Sign Up")
        }
        //        }.navigationBarHidden(true)
        //        .onAppear {
        //            viewModel.signedIn = viewModel.isSignedIn
        //        }
    }
}


struct SignInScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SignInScreenView()
    }
}

//}
