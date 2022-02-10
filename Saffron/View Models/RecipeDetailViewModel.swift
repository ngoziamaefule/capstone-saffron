//
//  RecipeDetailViewModel.swift
//  Saffron
//
//  Created by Ngozi Amaefule on 2/3/22.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestoreSwift



@MainActor
class RecipeDetailViewModel: ObservableObject {
    private var db: Firestore
    @Published var randomRecipes: [RandomRecipeViewModel] = []
    @Published var recipe: RecipeDetail? // Is this necessary? I want to get the recipe details of a recipe that's been saved.
    
    init() {
        db = Firestore.firestore()
    }
    
    func populateRecipeDetail() async {
        
        do {
            let recipeResponse = try await Webservice().get(url: Constants.Urls.recipeById()) { data -> RecipeDetailResponse? in
                do {
                    return try JSONDecoder().decode(RecipeDetailResponse.self, from: data)
                } catch {
                    let err = error
                    print("\(err)")
                    return nil
                }
            }
            
            self.randomRecipes = recipeResponse.recipes.map(RandomRecipeViewModel.init)
        } catch {
            print(error)
        }
        
    }
    
//    func loadRecipe(uid: String, documentID: String) {
//        //        let uid = viewModel.currentUser!.uid
//        db.collection("cookbooks").document(uid).collection("recipes").document(documentID).getDocument { doc, error in
//            if let error = error {
//                print(error.localizedDescription)
//            } else {
//                if let doc = doc {
//
//                    DispatchQueue.main.async {
//                        var recipeDetail = try? doc.data(as: RecipeDetail.self)
//                        recipeDetail?.documentID = doc.documentID
//                        self.recipe = recipeDetail!
//                        //                                return RecipeListItemViewModel(id: doc.documentID)
//                    }
//                }
//            }
//        }
//    }
}

