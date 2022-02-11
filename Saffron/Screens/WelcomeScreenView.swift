//
//  WelcomeScreenView.swift
//  Saffron
//
//  Created by Ngozi Amaefule on 2/2/22.
//

import SwiftUI

struct WelcomeScreenView: View {
    var body: some View {
        //        NavigationView {
        ZStack {
            Image(uiImage: #imageLiteral(resourceName: "Saffron.jpg"))
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .scaledToFill()
            
            VStack {
                Spacer()
                Text("Saffron")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                
                Spacer()
                
                NavigationLink(destination: SignInScreenView(), label: {
                    Text("Sign In")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.orange)
                        .cornerRadius(50)
                        .padding(.vertical)
                })
                //                    .navigationBarHidden(true)
                
                NavigationLink("Create Account", destination: SignUpScreenView())
                    .foregroundColor(Color.white)
            }
            //                NavigationLink("Create Account", destination: SignUpScreenView())
            //                    .foregroundColor(Color.white)
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        //        }
    }
}


struct WelcomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeScreenView()
    }
}
