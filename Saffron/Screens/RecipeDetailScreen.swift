//
//  RecipeDetailScreen.swift
//  Saffron
//
//  Created by Ngozi Amaefule on 2/3/22.
//

import SwiftUI
import FirebaseAuth
import Firebase
import FirebaseFirestoreSwift

struct RecipeDetailScreen: View {
    @EnvironmentObject var viewModel: AppViewModel
    
    private var db: Firestore
    
    
    init() {
        db = Firestore.firestore()
    }
    
    private func saveRecipe(recipe: RandomRecipeViewModel) {
        let uid = viewModel.currentUser!.uid
        _ = try? db.collection("cookbooks").document(uid).collection("recipes")
            .addDocument(from: recipe.recipe) { error in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    print("Document has been saved!")
                }
            }
        
    }
    
    // Once I change the array, edit this view to reflect changes
    @StateObject private var recipeDetailVM = RecipeDetailViewModel()
    let bounds = UIScreen.main.bounds
    
    var body: some View {
        //        TabView {
        ScrollView {
            VStack(alignment: .leading) {
                Text(recipeDetailVM.randomRecipes.first?.title ?? "")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color.black)
                    .padding()
//                    .background(Color.orange)
                    .cornerRadius(50.0)
                    .shadow(color: Color.black.opacity(0.88), radius: 60, x: 0.0, y: 16)
                    .padding(.bottom)
                
                AsyncImage(url: recipeDetailVM.randomRecipes.first?.image) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: bounds.width - 20)
                        .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
                } placeholder: {
                    ProgressView()
                }
                .padding(.bottom, 20)
                
                Text("Ingredients")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color.black)
                    .padding(.bottom)
                
                ForEach(recipeDetailVM.randomRecipes.first?.ingredients ?? [], id: \.id) { ingredient in
                    Text(ingredient.name)
                }
                
                Spacer()
                
                Text("Instructions")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color.black)
                    .padding(.vertical)
                
                Text(recipeDetailVM.randomRecipes.first?.instructions ?? "")
                
                HStack {
                    Button("Save Recipe!") {
                        saveRecipe(recipe: recipeDetailVM.randomRecipes.first!)
                    }
                    .font(.title3)
                    //                .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    .padding()
                    .background(Color.orange)
                    .cornerRadius(50.0)
                    .shadow(color: Color.orange.opacity(0.88), radius: 60, x: 0.0, y: 16)
                    .padding(.vertical)
                    
                    Spacer()
                    
//                    Button("Refresh Recipe") {
//                        await recipeDetailVM.populateRecipeDetail()
//                    }
                }
            }
            .padding()
            .task {
                await recipeDetailVM.populateRecipeDetail()
            }
        }
    }
    
    struct RecipeDetailScreen_Previews: PreviewProvider {
        static var previews: some View {
            RecipeDetailScreen()
        }
    }
}
