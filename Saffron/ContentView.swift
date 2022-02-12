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
                        RecipeDetailScreen()
                            .tabItem() {
                                VStack {
                                    Image(systemName: "fork.knife")
                                    Text("Random Recipes")
                                }
                                
                            }
//                        Divider()
                        
                        RecipeListScreen()
                            .tabItem() {
                                VStack {
                                    Image(systemName: "book.fill")
                                    Text("Cookbook")
                                }
                            }
                        //                            .navigationBarTitle("Saffron")
                    }
                    .accentColor(.orange)
                    //                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar { // <2>
                        ToolbarItem(placement: .principal) { // <3>
                            ZStack {
                                //                                Spacer()
                                //                                Spacer()
                                //                                Spacer()
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
                                        //                                        .font(.)
                                        //                            .fontWeight(.bold)
                                            .foregroundColor(Color.orange)
                                        //                                        .padding()
                                        //                                        .background(Color.orange)
                                        //                                        .cornerRadius(50.0)
                                        //                                .shadow(color: Color.orange.opacity(0.88), radius: 60, x: 0.0, y: 16)
                                            .padding(.all)
                                    })
                                }
                                //                                    .frame(width: 1.0, height: 1.0)
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
