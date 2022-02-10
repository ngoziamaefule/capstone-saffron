//
//  AppViewModel.swift
//  Saffron
//
//  Created by Ngozi Amaefule on 2/8/22.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class AppViewModel: ObservableObject {
    
    let auth = Auth.auth()
    
    @Published var signedIn = false
    var currentUser: User? {
        auth.currentUser
    }
    
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
//                self?.currentUser = result?.user
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
                // The exception for weak self
                self?.signedIn = true
//                self?.currentUser = result?.user
            }
        }
    }
    
    func signOut() throws {
        try auth.signOut()
        // The rule for self
        signedIn = false
//        currentUser = nil
        
    }
}
