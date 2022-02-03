//
//  RecipeCategoryListView.swift
//  Saffron
//
//  Created by Ngozi Amaefule on 2/3/22.
//

import SwiftUI

struct RecipeCategoryListView: View {
    
    let categories: [RecipeCategoryViewModel]
    
    var body: some View {
        List(categories) { category in
            
            NavigationLink(destination: RecipeListScreen(recipeCategory: category).navigationTitle(category.title)) {
                RecipeCategoryCellView(recipeCategory: category)
            }
        }.listStyle(.plain)
    }
}
