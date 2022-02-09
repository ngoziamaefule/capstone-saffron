//
//  Constants.swift
//  Saffron
//
//  Created by Ngozi Amaefule on 2/3/22.
//

import Foundation


// This is where I will use Spoonacular API
//struct Constants {
//
//    struct Urls {
//        static let recipeCategoriesURL = URL(string: "https://recipesapi.herokuapp.com/api/v2/categories")!
//
//        static func recipeByCategoryName(_ name: String) -> URL {
//            return URL(string: "https://recipesapi.herokuapp.com/api/v2/recipes?q=\(name)&page=1")!
//        }
//
//        static func recipeById(_ id: String) -> URL {
//            return URL(string: "https://recipesapi.herokuapp.com/api/v2/recipes/\(id)")!
//        }
//
//    }
//
//}

struct Constants {
    
    struct Urls {
//        static let recipeCategoriesURL = URL(string: "https://recipesapi.herokuapp.com/api/v2/categories")!
//
//        static func recipeByCategoryName(_ name: String) -> URL {
//            return URL(string: "https://recipesapi.herokuapp.com/api/v2/recipes?q=\(name)&page=1")!
//        }
        
        static func recipeById() -> URL {
            return URL(string: "https://api.spoonacular.com/recipes/random?apiKey=\(API_KEY)&number=1")!
        }
        
    }
    
}
