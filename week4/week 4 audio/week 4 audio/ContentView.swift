//
//  contentview.swift
//  week 4 audio
//
//  Created by 何若琪 on 10/1/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var audioManager: AudioManager
    var body: some View {
        NavigationView {
            
                VStack {
                    Image(systemName: "music.quarternote.3")
                        .resizable()
                        .foregroundColor(Color.pink)
                        .frame(width:100, height: 100)
                    NavigationLink (destination: MusicPlaylistView(expandSheet: .constant(true), animation: Namespace().wrappedValue)) {
                        Text("YourOwnFM")
                            .font(.largeTitle)
                            .fontWeight(.thin)
                            .foregroundColor(Color.pink)
                            .multilineTextAlignment(.leading)
                        
                    NavigationLink (destination: ArtistNavigationView()) {
                        Text("Your Liked Songs")
                            .font(.largeTitle)
                            .fontWeight(.thin)
                            .foregroundColor(Color.blue)
                            .multilineTextAlignment(.leading)
                            .lineSpacing(20)
                        }
                    }
                    
                    
                }
            }
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
