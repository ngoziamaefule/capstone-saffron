//
//  RecipeCategoryListScreen.swift
//  Saffron
//
//  Created by Ngozi Amaefule on 2/3/22.
//

//import SwiftUI
//
//struct RecipeCategoryListScreen: View {
//    
//    @EnvironmentObject var viewModel: AppViewModel
//    @StateObject var model: RecipeCategoryListViewModel = RecipeCategoryListViewModel()
//    
//    var body: some View {
//        //        NavigationView {
//        VStack {
//            RecipeCategoryListView(categories: model.recipeCategories)
//                .task {
//                    await model.populateCategories()
//                }
//                .navigationTitle("Recipes")
//            //        }
//            Button(action: {
//                do {
//                    try viewModel.signOut()
//                    
//                }
//                catch {}
//            }, label: {Text("Sign Out")})
//        }
//    }
//}
//
//struct RecipeCategoryListScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        RecipeCategoryListScreen()
//    }
//}
