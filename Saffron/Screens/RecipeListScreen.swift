//
//  RecipeListScreen.swift
//  Saffron
//
//  Created by Ngozi Amaefule on 2/3/22.
//

import SwiftUI
import FirebaseFirestore
//
struct RecipeListScreen: View {
    //
    //  Keep in mind that I have model types that have the content of the sturcture. It's codable (bi-directional).
    
    @EnvironmentObject var viewModel: AppViewModel
    private var db: Firestore
    @State private var randomRecipe: String = ""
    
    init() {
        db = Firestore.firestore()
    }
   
    // Look up retrieving a list from firestore. (May correspond with what goes in RecipeListViewModel
    private func loadRecipeList() {
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
                
                //                        MOVE THIS TO THE VIEW MODEL!!!
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
            //            }
            
        }
    }
//    let recipeCategory: RecipeCategoryViewModel
//    @StateObject private var recipeListVM = RecipeListViewModel()
//    
//    var body: some View {
//        RecipeListView(recipes: recipeListVM.recipes)
//            .task {
//                await recipeListVM.populateRecipesByCategory(name: recipeCategory.title)
//            }
//    }
//}
//
//struct RecipeListScreen_Previews: PreviewProvider {
//    static var previews: some View {
//       
//        let recipeCategoryVM = RecipeCategoryViewModel(RecipeCategory(imageUrl: "https://res.cloudinary.com/dk4ocuiwa/image/upload/v1618257399/RecipesApi/Chicken.png", title: "Chicken"))
//        
//        RecipeListScreen(recipeCategory: recipeCategoryVM)
//    }
//}
