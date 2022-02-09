//
//  ContentView.swift
//  Saffron
//
//  Created by Ngozi Amaefule on 2/2/22.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        NavigationView  {
            
            if viewModel.isSignedIn {
                TabView {
                    RecipeDetailScreen()
                        .tabItem() {
                            VStack {
                                Image(systemName: "book")
                                Text("Cookbook")
                            }
                            
                        }
                    RecipeDetailScreen()
                        .tabItem() {
                            VStack {
                                Image(systemName: "book.fill")
                                Text("Cookbook")
                            }
                        }
                }
                .accentColor(.orange)
            }
            else {
                WelcomeScreenView()
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

