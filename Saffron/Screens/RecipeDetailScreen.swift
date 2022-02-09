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
    @State private var randomRecipe: String = ""
    
    
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
    
    @StateObject private var recipeDetailVM = RecipeDetailViewModel()
    let bounds = UIScreen.main.bounds
    
    var body: some View {
        //        TabView {
        ScrollView {
            VStack(alignment: .leading) {
                Text(recipeDetailVM.randomRecipe.first?.title ?? "")
                AsyncImage(url: recipeDetailVM.randomRecipe.first?.image) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: bounds.width - 20)
                        .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
                } placeholder: {
                    ProgressView()
                }
                .padding(.bottom, 20)
                
                ForEach(recipeDetailVM.randomRecipe.first?.ingredients ?? [], id: \.id) { ingredient in
                    Text(ingredient.name)
                }
                
                Text(recipeDetailVM.randomRecipe.first?.instructions ?? "")
                
                
                Button("Save Recipe!") {
                    saveRecipe(recipe: recipeDetailVM.randomRecipe.first!)
                }
                
                Spacer()
                
                Button(action: {
                    do {
                        try viewModel.signOut()
                        
                    }
                    catch {}
                }, label: {Text("Sign Out")})
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
