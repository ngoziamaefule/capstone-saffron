//
//  RecipeListView.swift
//  Saffron
//
//  Created by Ngozi Amaefule on 2/3/22.
//

import SwiftUI

struct RecipeListView: View {
    
    let recipes: [RecipeViewModel]
    
    var body: some View {
        List(recipes, id: \.id) { recipe in
            NavigationLink(destination: RecipeDetailScreen(recipeId: recipe.id).navigationTitle(recipe.title)) {
                RecipeCellView(recipe: recipe)
            }
        }
    }
}
