//
//  RecipeCellView.swift
//  Saffron
//
//  Created by Ngozi Amaefule on 2/3/22.
//

import SwiftUI

struct RecipeCellView: View {
    
    let recipe: RecipeViewModel
    
    var body: some View {
        HStack {
            
            AsyncImage(url: recipe.imageURL) { image in
                image.resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
            } placeholder: {
                ProgressView()
            }
            
            Text(recipe.title)
        }
    }
}
