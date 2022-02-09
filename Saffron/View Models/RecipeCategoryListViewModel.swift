//
//  RecipeCategoryListViewModel.swift
//  Saffron
//
//  Created by Ngozi Amaefule on 2/3/22.
//

import Foundation

//// Represents the entire screen of recipe categories, i.e. the LIST of recipe categories
//
//@MainActor // This means that every single property and function called on RecipeCategoryListViewModel will be called on the main thread, recipeCategories, which is published (line 16)
//
//class RecipeCategoryListViewModel: ObservableObject {
//    
//    @Published var recipeCategories: [RecipeCategoryViewModel] = []
//    
//    func populateCategories() async {
//        
//        do {
//            let recipeCategoryResponse = try await Webservice().get(url: Constants.Urls.recipeCategoriesURL) { data in
//                return try? JSONDecoder().decode(RecipeCategoryResponse.self, from: data)
//            }
//            
//            self.recipeCategories = recipeCategoryResponse.categories.map(RecipeCategoryViewModel.init)
//            
//        } catch {
//            print(error)
//        }
//        
//    }
//    
//}
//
//struct RecipeCategoryViewModel: Identifiable {
//    
//    let id = UUID()
//    private let recipeCategory: RecipeCategory
//    
//    init(_ recipeCategory: RecipeCategory) {
//        self.recipeCategory = recipeCategory
//    }
//    
//    var title: String {
//        recipeCategory.title
//    }
//    
//    var imageUrl: URL? {
//        URL(string: recipeCategory.imageUrl)
//    }
//    
//}
