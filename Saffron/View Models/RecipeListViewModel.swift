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
    @Published var recipes: [RecipeListItemViewModel] = [RecipeListItemViewModel]()
    @Published var recipe: RandomRecipeViewModel?
    
    init() {
        db = Firestore.firestore()
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
    }




