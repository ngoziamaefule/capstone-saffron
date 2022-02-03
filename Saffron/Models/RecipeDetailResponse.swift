//
//  RecipeDetailResponse.swift
//  Saffron
//
//  Created by Ngozi Amaefule on 2/3/22.
//

import Foundation

struct RecipeDetailResponse: Decodable {
    let recipe: RecipeDetail
}

struct RecipeDetail: Decodable {
    let imageUrl: String
    let id: String
    let title: String
    let ingredients: [String]
}
