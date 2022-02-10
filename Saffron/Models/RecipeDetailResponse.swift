//
//  RecipeDetailResponse.swift
//  Saffron
//
//  Created by Ngozi Amaefule on 2/3/22.
//

import Foundation
import FirebaseFirestoreSwift

struct RecipeDetailResponse: Decodable {
    let recipes: [RecipeDetail]
}

struct RecipeDetail: Codable {
    var documentID: String?
    let image: String?
    let id: Int
    let title: String?
    let extendedIngredients: [IngredientRecord]
    let instructions: String?
}

struct IngredientRecord: Codable {
    let id: Int
    let name: String
    let measures: IngredientMeasurement
}

struct IngredientMeasurement: Codable {
    let us: IngredientAmount
    let metric: IngredientAmount
}

struct IngredientAmount: Codable {
    let amount: Double
    let unitShort: String
    let unitLong: String
}
