//
//  RecipeListScreen.swift
//  Saffron
//
//  Created by Ngozi Amaefule on 2/3/22.
//

import SwiftUI
import FirebaseFirestore

struct RecipeListScreen: View {
    @EnvironmentObject var viewModel: AppViewModel
    //    private let db = Firestore.firestore()
    private var db: Firestore
    
    init() {
        db = Firestore.firestore()
    }
    
    
    
    // Create an instance of RecipeListViewModel and make it observable
    
    @StateObject private var recipeListVM = RecipeListViewModel()
    //    var documentID: String
    let bounds = UIScreen.main.bounds
    
    var body: some View {
        
        VStack {
//            Text("Your Cookbook")
//                .font(.title)
//                .fontWeight(.bold)
//                .foregroundColor(Color.orange)
//                .padding()
////                .cornerRadius(50.0)
//                .shadow(color: Color.orange.opacity(0.88), radius: 60, x: 0.0, y: 16)
//                .padding(.bottom)
            
            List (recipeListVM.recipes) { recipe in
                
                NavigationLink(destination: RecipeListItemDetailView(documentID: recipe.documentID).navigationTitle(recipe.title)) {
                    HStack(spacing: 20) {
                        AsyncImage(url: recipe.image) { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: 100, maxHeight: 100)
                                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                        } placeholder: {
                            ProgressView()
                        }
                        
                        Text(recipe.title)
                    }
                }
                
            }.onAppear {
                recipeListVM.loadRecipeList(uid: viewModel.currentUser!.uid) // This is correct, I worked on it with Ansel
            }
        }
//        .navigationBarTitleDisplayMode(.inline)
    }
}
