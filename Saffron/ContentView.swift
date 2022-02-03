//
//  ContentView.swift
//  Saffron
//
//  Created by Ngozi Amaefule on 2/2/22.
//

import SwiftUI
import FirebaseAuth

//class AppViewModel: ObservableObject {
//    
//    let auth = Auth.auth()
//    
//    @Published var signedIn = false
//    
//    var isSignedIin: Bool {
//        return auth.currentUser != nil
//    }
//    
//    func signIn(email: String, password: String) {
//        auth.signIn(withEmail: email, password: password) { [weak self] result, error in
//            guard result != nil, error == nil else {
//                return
//            }
//            
//            DispatchQueue.main.async {
//                // Success
//                self?.signedIn = true
//            }
//        }
//    }
//    
//    func signUp(email: String, password: String) {
//        auth.createUser(withEmail: email, password: password) { [weak self] result, error in
//            guard result != nil, error == nil else {
//                return
//            }
//            
//            DispatchQueue.main.async {
//                // Success
//                self?.signedIn = true
//            }
//        }
//    }
//}

struct ContentView: View {
    
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        NavigationView  {
            WelcomeScreenView()
            //            if viewModel.signedIn {
            //                Text("You are signed in!")
            //                RecipeCategoryListScreen()
            //            }
            //            else {
            //                SignInScreenView()
            //            }
            //            RecipeCategoryListScreen()
            //        }
                .onAppear {
                    viewModel.signedIn = viewModel.isSignedIn
                }
            
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
    
    struct PrimaryButton: View {
        var title: String
        var body: some View {
            Text("Create Account")
                .font(.title3)
                .fontWeight(.bold)
                .padding()
                .background(Color.white)
                .cornerRadius(50.0)
                .shadow(color: Color.black.opacity(0.88), radius: 60, x: 0.0, y: 16)
        }
    }
}

