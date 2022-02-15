//
//  RecipeListScreen.swift
//  Saffron
//
//  Created by Ngozi Amaefule on 2/3/22.
//
import SwiftUI
import FirebaseFirestore

struct RecipeListScreen: View {
    @EnvironmentObject var viewModel: AppViewModel
    //    private let db = Firestore.firestore()
    private var db: Firestore
    
    init() {
        db = Firestore.firestore()
    }
    
    
    
    // Create an instance of RecipeListViewModel and make it observable
    
    @StateObject private var recipeListVM = RecipeListViewModel()
    //    var documentID: String
    let bounds = UIScreen.main.bounds
    @State var searchTerm = ""
    
    var body: some View {
        
        VStack {
            SearchBar(searchTerm: $searchTerm)
            
            List {
                ForEach(recipeListVM.sectionDictionary.keys.sorted(), id:\.self) { key in
                    if let recipes = recipeListVM.sectionDictionary[key]!.filter({ (recipe) -> Bool in
                        self.searchTerm.isEmpty ? true :
                        recipe.title.lowercased().contains(self.searchTerm.lowercased())}), !recipes.isEmpty
                    {
                        Section(header: Text(key)) {
                            
                            ForEach(recipes){ value in
                                NavigationLink(destination: RecipeListItemDetailView(documentID: value.documentID, recipeListVM: recipeListVM).navigationTitle(value.title)) {
                                    HStack(spacing: 20) {
                                        AsyncImage(url: value.image) { image in
                                            image.resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(maxWidth: 100, maxHeight: 100)
                                                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                                        } placeholder: {
                                            ProgressView()
                                        }
                                        
                                        Text(value.title)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .listStyle(GroupedListStyle())
            
            
            //            List (recipeListVM.recipes) { recipe in
            //
            //                NavigationLink(destination: RecipeListItemDetailView(documentID: recipe.documentID, recipeListVM: recipeListVM).navigationTitle(recipe.title)) {
            //                    HStack(spacing: 20) {
            //                        AsyncImage(url: recipe.image) { image in
            //                            image.resizable()
            //                                .aspectRatio(contentMode: .fit)
            //                                .frame(maxWidth: 100, maxHeight: 100)
            //                                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            //                        } placeholder: {
            //                            ProgressView()
            //                        }
            //
            //                        Text(recipe.title)
            //                    }
            //                }
            //
            //            }
            //            .onAppear {
            //                recipeListVM.loadRecipeList(uid: viewModel.currentUser!.uid) // This is correct, I worked on it with Ansel
            
        }
        .onAppear {
            recipeListVM.loadRecipeList(uid: viewModel.currentUser!.uid)
        }
    }
}
