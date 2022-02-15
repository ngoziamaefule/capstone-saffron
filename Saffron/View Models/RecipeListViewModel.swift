//
//  RecipeListViewModel.swift
//  Saffron
//
//  Created by Ngozi Amaefule on 2/3/22.
//
// Think "inverse of the saveData func"

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestoreSwift

@MainActor
class RecipeListViewModel: ObservableObject {
    private var db: Firestore
    var recipes: [RecipeListItemViewModel] = [RecipeListItemViewModel]()
    @Published var sectionDictionary : Dictionary<String , [RecipeListItemViewModel]> = [:]
    @Published var recipe: RandomRecipeViewModel?
    
    init() {
        db = Firestore.firestore()
    }
    
    func getSectionedDictionary() -> Dictionary <String, [RecipeListItemViewModel]> {
        let sectionDictionary: Dictionary<String, [RecipeListItemViewModel]> = {
            return Dictionary(grouping: recipes.sorted(by: { lhs, rhs in
                return lhs.title < rhs.title
            }), by: {
                let recipe = $0.title
                let normalizedRecipe = recipe.folding(options: [.diacriticInsensitive, .caseInsensitive], locale: .current)
                let firstChar = String(normalizedRecipe.first!).uppercased()
                return firstChar
            })
        }()
        return sectionDictionary
    }
    
    // making a call to loadRecipeList function instead of using url
    
    func loadRecipeList(uid: String) {
//        let uid = viewModel.currentUser!.uid
        db.collection("cookbooks").document(uid).collection("recipes").getDocuments { snapshot, error in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    if let snapshot = snapshot {
                        
                        DispatchQueue.main.async {
                            self.recipes = snapshot.documents.map { doc in
                                var recipeDetail = try? doc.data(as: RecipeDetail.self)
                                recipeDetail?.documentID = doc.documentID // this is the document ID of the individual recipe
                                return RecipeListItemViewModel(recipeDetail!)
//                                return RecipeListItemViewModel(id: doc.documentID)
                            }
                            self.sectionDictionary = self.getSectionedDictionary()
                        }
                    }
                }
            }
        
    }
// The document snapshot itself has document id which I will need to pass in to the subcollection
    func loadRecipe(uid: String, documentID: String) {
        //        let uid = viewModel.currentUser!.uid
        db.collection("cookbooks").document(uid).collection("recipes").document(documentID).getDocument { doc, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                if let doc = doc {
                    
                    DispatchQueue.main.async {
                        var recipeDetail = try? doc.data(as: RecipeDetail.self)
                        recipeDetail?.documentID = doc.documentID
                        self.recipe = RandomRecipeViewModel(recipeDetail!)
                    }
                }
            }
        }
    }

    func deleteRecipe(uid: String, documentID: String) {
            db.collection("cookbooks").document(uid).collection("recipes").document(documentID).delete { error in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    self.loadRecipeList(uid: uid)
                }
            }
        }
    
    func updateRecipe(uid: String, documentID: String, recipeNote: String, completion: @escaping () -> ()) {
        let updatedRecipe = db.collection("cookbooks").document(uid).collection("recipes").document(documentID)
        
        updatedRecipe.updateData(["recipeNote": recipeNote]) { error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("Update successful")
                completion()
            }
//            } else {
//                if let doc = doc {
//
//                    DispatchQueue.main.async {
//                        var recipeDetail = try? doc.data(as: RecipeDetail.self)
//                        recipeDetail?.documentID = doc.documentID
//                        self.recipe = RandomRecipeViewModel(recipeDetail!)
//                    }
//                }
//
//            }
        }
        
        
    }
    
//    func saveRecipeNotes(uid: String, documentID: String) {
//        //        let uid = viewModel.currentUser!.uid
//        db.collection("cookbooks").document(uid).collection("recipes").document(documentID).collection("") { doc, error in
//            if let error = error {
//                print(error.localizedDescription)
//            } else {
//                if let doc = doc {
//
//                    DispatchQueue.main.async {
//                        var recipeDetail = try? doc.data(as: RecipeDetail.self)
//                        recipeDetail?.documentID = doc.documentID
//                        self.recipe = RandomRecipeViewModel(recipeDetail!)
//                    }
//                }
//            }
//        }
//    }
    
    }




