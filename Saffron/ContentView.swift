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
                    
                    TabView {
//                        RecipeDetailScreen()
                        GeometryReader { proxy in
                            RecipeCardView(proxy: proxy)
                        }
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
                    .tabViewStyle(DefaultTabViewStyle())
                    .toolbar {
                        ToolbarItem(placement: .principal) {
                            ZStack {
                                HStack {
                                    Spacer()
                                    Text("Saffron").font(.largeTitle.bold()).foregroundColor(Color.orange).italic()
                                    Spacer()
                                }
                                
                                HStack {
                                    Spacer()
                                    Button(action: {
                                        do {
                                            try viewModel.signOut()
                                        }
                                        catch {}
                                    }, label: {Text("Sign Out")
                                            .foregroundColor(Color.orange)
                                            .padding(.all)
                                    })
                                }
                            }
                        }
                    }
                }
            }
            else {
                WelcomeScreenView()
            }
        }
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
