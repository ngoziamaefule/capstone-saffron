//
//  RecipeDetailScreen.swift
//  Saffron
//
//  Created by Ngozi Amaefule on 2/3/22.
//
import SwiftUI
import FirebaseAuth
import Firebase
import FirebaseFirestoreSwift


struct RecipeDetailScreen: View {
    @EnvironmentObject var viewModel: AppViewModel
    private let db = Firestore.firestore()
    @State var isPerformingTask = false
    
    
    
    //    private var db: Firestore
    //
    //    init() {
    //        db = Firestore.firestore()
    //    }
    
    
    
    private func saveRecipe(recipe: RandomRecipeViewModel) {
        let uid = viewModel.currentUser!.uid
        _ = try? db.collection("cookbooks").document(uid).collection("recipes")
            .addDocument(from: recipe.recipe) { error in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    print("Document has been saved!")
                }
            }
        
    }
    
    
    // Once I change the array, edit this view to reflect changes
    @StateObject private var recipeDetailVM = RecipeDetailViewModel()
    let bounds = UIScreen.main.bounds
    
    
    var body: some View {
        
        let backgroundGradient = LinearGradient(
            colors: [Color.white, recipeDetailVM.backgroundColor],
            startPoint: .top, endPoint: .bottom)
        //        ZStack {
        //            Text("Hi")
        //                .background(Color.white.opacity(1.0))
        //                .frame(maxWidth: .infinity, maxHeight: .infinity)
        NavigationView {
        ScrollView {
//            ScrollViewReader { value in
                
                VStack(alignment: .leading) {
                    Text(recipeDetailVM.randomRecipes.first?.title ?? "")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color.black)
                        .padding()
                    //                    .background(Color.orange)
                        .cornerRadius(50.0)
                        .shadow(color: Color.black.opacity(0.88), radius: 60, x: 0.0, y: 16)
                        .padding(.bottom)
                    //                GeometryReader { geometry in
                    if let image = recipeDetailVM.image {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .aspectRatio(contentMode: .fit)
                        //                        .frame(width: geometry.size.width * 0.8, height: geometry.size.width * 0.8)
                            .frame(width: bounds.width - 20)
                            .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
                        //                        .clipped()
                            .cornerRadius(10)
                            .shadow(radius: 10)
                            .padding(.bottom, 20)
                        
                    } else {
                        ProgressView()
                    }
                    
//                    HStack {
//                        Spacer()
//                        
//                        Button("Refresh!") {
//                            if !isPerformingTask {
//                                
//                                isPerformingTask = true
//                                Task {
//                                    await recipeDetailVM.populateRecipeDetail()
//                                    isPerformingTask = false
//                                }
//                            }
//                        }
//                        .font(.title3)
//                        //                .fontWeight(.bold)
//                        .foregroundColor(Color.white)
//                        .padding()
//                        .background(Color.orange)
//                        .cornerRadius(50.0)
//                        .shadow(color: Color.orange.opacity(0.88), radius: 60, x: 0.0, y: 16)
//                        .padding(.vertical)
//                        .disabled(isPerformingTask)
//                        
//                        Spacer()
//                    }
                    
                    Text("Ingredients")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color.black)
                        .padding(.bottom)
                    
                    ForEach(recipeDetailVM.randomRecipes.first?.ingredients ?? [], id: \.id) { ingredient in
                        Text(ingredient.name)
                    }
                    
                    Spacer()
                    
                    Text("Instructions")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color.black)
                        .padding(.vertical)
                    
                    Text(recipeDetailVM.randomRecipes.first?.instructions ?? "")
                    
                    HStack {
                        Spacer()
                        
                        Button("Save Recipe!") {
                            saveRecipe(recipe: recipeDetailVM.randomRecipes.first!)
//                            value.scrollTo(<#_#>, anchor: .top)
                            if !isPerformingTask {
                                
                                isPerformingTask = true
                                Task {
                                    await recipeDetailVM.populateRecipeDetail()
                                    isPerformingTask = false
                                }
                            }
                            
                        }
                        .font(.title3)
                        //                .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .padding()
                        .background(Color.orange)
                        .cornerRadius(50.0)
                        .shadow(color: Color.orange.opacity(0.88), radius: 60, x: 0.0, y: 16)
                        .padding(.vertical)
                        
                        Spacer()
                    }
                }
//            }
            .padding()
            
            .task {
                await recipeDetailVM.populateRecipeDetail()
            }
        }
        //        }
        .background(backgroundGradient)
//        .edgesIgnoringSafeArea(.all)
    }
    }
    
    
//    struct RecipeDetailScreen_Previews: PreviewProvider {
//        static var previews: some View {
//            RecipeDetailScreen(action: populateRecipeDetail())
//        }
//    }
}

