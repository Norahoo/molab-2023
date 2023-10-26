//
//  ContentView.swift
//  Photopicker
//
//  Created by 何若琪 on 10/26/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var profileImage: Image = Image("Profile")
    
    var body: some View {
        VStack {
            ZStack{
                
                Color.red
                
                profileImage
                
                profileImage
                    .profeileImageStyle()
            }
            
            Spacer()
            
        }
        .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
