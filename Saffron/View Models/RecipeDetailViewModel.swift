//
//  RecipeDetailViewModel.swift
//  Saffron
//
//  Created by Ngozi Amaefule on 2/3/22.
//

import Foundation

@MainActor
class RecipeDetailViewModel: ObservableObject {
    
    @Published var imageUrl: URL?
    @Published var title: String = ""
    @Published var ingredients: [String] = []
    
    func populateRecipeDetail(recipeId: String) async {
        
        do {
            let recipeDetailResponse = try await Webservice().get(url: Constants.Urls.recipeById(recipeId)) { data in
                return try? JSONDecoder().decode(RecipeDetailResponse.self, from: data)
            }
            
            let recipeDetail = recipeDetailResponse.recipe
            self.imageUrl = URL(string: recipeDetail.imageUrl)!
            self.title = recipeDetail.title
            self.ingredients = recipeDetail.ingredients
            
        } catch {
            print(error)
        }
        
    }
    
}
