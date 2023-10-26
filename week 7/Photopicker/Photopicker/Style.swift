//
//  Style.swift
//  Photopicker
//
//  Created by 何若琪 on 10/26/23.
//

import SwiftUI

extension Image{
    func profileImageStyle() -> some View{
        self.resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 150, height: 150)
            .clipShape(Circle())
            .clipped()
            .overlay(){
                ZStack{
                    Image(systemName: "cmaera.fill")
                        .foregroundColor(. gray)
                        .offset(y: 60)
                    
                    RoundRectangle(cornerRadius: 100)
                        .stroke(.white, lineWidth: 4)
                }
            }
    }
}
