//
//  RecipeCardView.swift
//  Saffron
//
//  Created by Ngozi Amaefule on 2/13/22.
//

import Foundation
import SwiftUI
import FirebaseAuth
import Firebase
import FirebaseFirestoreSwift

struct RecipeCardView: View {
    @EnvironmentObject var viewModel: AppViewModel
    private let db = Firestore.firestore()
    
    let proxy: GeometryProxy
    @GestureState var translation: CGSize = .zero
    @GestureState var degrees: Double = 0
    @GestureState var isDragging: Bool = false
    @State var isPerformingTask = false
    
    let threshold: CGFloat = 0.5
    //    let onRemove: ((Bool) -> Void?)
    
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
    
    @StateObject private var recipeDetailVM = RecipeDetailViewModel()
    let bounds = UIScreen.main.bounds
    
    var body: some View {
        let backgroundGradient = LinearGradient(
            colors: [Color.white, recipeDetailVM.backgroundColor],
            startPoint: .top, endPoint: .bottom)
        
        let dragGesture = DragGesture()
            .updating($translation) { (value, state, _) in
                state = value.translation
            }
            .updating($degrees) { (value, state, _) in
                state = value.translation.width > 0 ? 2 : 2
            }
            .updating($isDragging) { (value, state, _) in
                state = value.translation.width != 0
            }
            .onEnded { (value) in
                let dragPercentage = value.translation.width / proxy.size.width
                
                if dragPercentage > threshold {
                    // I want it to show that particular recipe's detail screen.
                    saveRecipe(recipe: recipeDetailVM.randomRecipes.first!)
                    
                    if !isPerformingTask {
                        
                        isPerformingTask = true
                        Task {
                            await recipeDetailVM.populateRecipeDetail()
                            isPerformingTask = false
                        }
                    }
                    
                }
                if dragPercentage < threshold {
                    // remove the card
                    if !isPerformingTask {
                        
                        isPerformingTask = true
                        Task {
                            await recipeDetailVM.populateRecipeDetail()
                            isPerformingTask = false
                        }
                    }
                    
                }
            }
        
        
        VStack {
            Text(recipeDetailVM.randomRecipes.first?.title ?? "")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color.black)
                .padding()
                .cornerRadius(50.0)
                .shadow(color: Color.black.opacity(0.88), radius: 60, x: 0.0, y: 16)
                .padding(.bottom)
   
        Rectangle()
            .overlay(
                ZStack {
                    GeometryReader { proxy in
                        if let image = recipeDetailVM.image {
                            Image(uiImage: image)
                                .centerCropped()
                        } else {
                            ProgressView()
                        }
                        
                        //                            Rectangle()
                        //                                .overlay(Text("👎"))
                        //                                .foregroundColor(Color.red)
                        //                                .opacity(degrees < 0 ? 1 : 0)
                        //                                .frame(width: 50, height: 50)
                        //                                .cornerRadius(25)
                        //                                .position(
                        //                                    x: proxy.frame(in: .local).midX,
                        //                                    y: proxy.frame(in: .local).midY
                        //                                )
                        //                                .scaleEffect(isDragging ? 2 : 1)
                        //
                        //                            Rectangle()
                        //                                .overlay(Text("❤️"))
                        //                                .foregroundColor(Color.green)
                        //                                .opacity(degrees > 0 ? 1 : 0)
                        //                                .frame(width: 50, height: 50)
                        //                                .cornerRadius(25)
                        //                                .position(
                        //                                    x: proxy.frame(in: .local).midX,
                        //                                    y: proxy.frame(in: .local).midY
                        //                                )
                        //                                .scaleEffect(isDragging ? 2 : 1)
                    }
                    .task {
                        await recipeDetailVM.populateRecipeDetail()
                    }
                    
                }
            )
            .cornerRadius(10)
            .frame(
                maxWidth: proxy.size.width - 28,
                maxHeight: proxy.size.height * 0.70
            )
        
            .position(
                x: proxy.frame(in: .global).midX,
                y: proxy.frame(in: .local).midY - 90
            )
            .offset(x: translation.width, y: 0)
            .rotationEffect(.degrees(degrees))
            .gesture(dragGesture)
            .background(backgroundGradient)
    }
    }
}
