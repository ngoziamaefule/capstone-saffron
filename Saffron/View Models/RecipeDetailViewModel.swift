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
    @Published var randomRecipe: [RandomRecipeViewModel] = []
    
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
            
            self.randomRecipe = recipeResponse.recipes.map(RandomRecipeViewModel.init)
        } catch {
            print(error)
        }
        
    }
    
}

struct RandomRecipeViewModel {
    
    let recipe: RecipeDetail
    
    init(_ recipe: RecipeDetail) {
        self.recipe = recipe
    }
    
    var id: Int {
        recipe.id
    }
    
    var title: String {
        recipe.title ?? ""
    }
    
    var image: URL? {
        if let recipeImage = recipe.image {
            return URL(string: recipeImage)
        }
        
        return nil
        
    }
    
    var ingredients: [IngredientRecord] {
        recipe.extendedIngredients
    }
    
    var instructions: String {
        recipe.instructions ?? ""
    }
}

