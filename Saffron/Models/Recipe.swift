//
//  Recipe.swift
//  Saffron
//
//  Created by Ngozi Amaefule on 2/3/22.
//

import Foundation

struct RecipeResponse: Decodable {
    let recipes: [Recipe]
}

struct Recipe: Decodable {
    let id: String
    let imageUrl: String
    let title: String
}
