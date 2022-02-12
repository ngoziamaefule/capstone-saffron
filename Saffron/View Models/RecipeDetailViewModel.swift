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
    @Published var randomRecipes: [RandomRecipeViewModel] = []
    @Published var recipe: RecipeDetail? // Is this necessary? I want to get the recipe details of a recipe that's been saved.
    @Published var backgroundColor: Color = .clear
    @Published var image: UIImage?
    
    init() {
        db = Firestore.firestore()
    }
    
//    func populateRecipeDetail() async {
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
            
            self.randomRecipes = recipeResponse.recipes.map(RandomRecipeViewModel.init)
            await setAverageColor()
        } catch {
            print(error)
        }
        
    }
    
    private func setAverageColor() async {
        let url = randomRecipes.first?.image
        guard let url = url else { return }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let image = UIImage(data: data)
            let uiColor = image?.averageColor ?? .clear
            backgroundColor = Color(uiColor)
            self.image = image
        } catch {
            print(error)
        }

    }
}

