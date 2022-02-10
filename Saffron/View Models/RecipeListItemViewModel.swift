//
//  RecipeListItemViewModel.swift
//  Saffron
//
//  Created by Ngozi Amaefule on 2/9/22.
//

import Foundation

// Consider what I actually want visible in the list (the image, the title) the extra wrapper that I'm using is the view model
// As I'm retriving data from firestore, use a view model that only has the image and title

struct RecipeListItemViewModel: Identifiable {
    
    let recipe: RecipeDetail
    
    init(_ recipe: RecipeDetail) {
        self.recipe = recipe
    }
    // implement the identifiable protocol
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
}
