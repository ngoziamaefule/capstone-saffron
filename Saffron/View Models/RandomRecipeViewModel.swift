//
//  RandomRecipeViewModel.swift
//  Saffron
//
//  Created by Ngozi Amaefule on 2/9/22.
//

import Foundation


struct RandomRecipeViewModel {
    
    let recipe: RecipeDetail
    
    init(_ recipe: RecipeDetail) {
        self.recipe = recipe
    }
    
    var id: Int {
        recipe.id
    }
    
    var documentID: String {
        recipe.documentID!
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
    
    var recipeNote: String {
        recipe.recipeNote ?? ""
    }
}
