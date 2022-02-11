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
                VStack {
                    
                    VStack {
                        Text("Saffron")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(Color.orange)
//                            .padding(.bottom)
//                            .background(Color.white)
//                            .cornerRadius(50.0)
                            .shadow(color: Color.orange.opacity(0.88), radius: 60, x: 0.0, y: 16)
//                            .padding()
                        
//                        Spacer()
                        
                        Button(action: {
                            do {
                                try viewModel.signOut()
                            }
                            catch {}
                        }, label: {Text("Sign Out")
                                .font(.title3)
//                            .fontWeight(.bold)
                                .foregroundColor(Color.white)
                                .padding()
                                .background(Color.orange)
                                .cornerRadius(50.0)
//                                .shadow(color: Color.orange.opacity(0.88), radius: 60, x: 0.0, y: 16)
                                .padding(.bottom)
                        })
                    }
                    // Move sign out button here
                    TabView {
                        RecipeDetailScreen()
                            .tabItem() {
                                VStack {
                                    Image(systemName: "fork.knife")
                                    Text("Random Recipes")
                                }
                                
                            }
                        RecipeListScreen()
                            .tabItem() {
                                VStack {
                                    Image(systemName: "book.fill")
                                    Text("Cookbook")
                                }
                            }
                    }
                    .accentColor(.orange)
                }
            }
            else {
                WelcomeScreenView()
            }
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        
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

