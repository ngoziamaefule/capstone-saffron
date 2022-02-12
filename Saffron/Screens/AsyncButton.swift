//
//  AsyncButton.swift
//  Saffron
//
//  Created by Ngozi Amaefule on 2/11/22.
//

//import Foundation
//import SwiftUI
//import FirebaseAuth
//import Firebase
//import FirebaseFirestoreSwift
////import SwiftProtobuf
//
//struct AsyncButton: View {
//    var action: () async -> Void
////    init (@ViewBuilder title: Text("Refresh"), @Viewbuilder icon: Image(systemImage: "fork.knife"))
//    @ViewBuilder var label = Label(Title: "Refresh", Icon: Image(systemName("fork.knife")))
//    
//    @State private var isPerformingTask = false
//    
//    var body: some View {
//        Button (
//            action: {
//                isPerformingTask = true
//                
//                Task {
//                    await action()
//                    isPerformingTask = false
//                }
//            }, label: {
//                ZStack {
//                    
//                }
//            }
//        )
//            .disabled(isPerformingTask)
//    }
//}
