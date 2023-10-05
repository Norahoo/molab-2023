//
//  File.swift
//  week 4 audio
//
//  Created by 何若琪 on 10/5/23.
//



import SwiftUI

struct ArtistNavigationView: View {
    @State private var navPath = NavigationPath()
    
    let selections = ["Fargo","Stand By Me"]
    
    var body: some View {
        NavigationStack(path: $navPath) {
            VStack {
                // Button does not appear if after List
                Button("Tap for random A-D") {
                    guard let sel = selections.randomElement() else { return }
                    // Select Previews at bottom of Debug Area to see print output
                    print("sel", sel)
                    navPath.append(sel)
                }
                List(selections, id: \.self ) { str in
                    NavigationLink(value: str) {
                        Text( ""+str )
                    }
                }
            }
            .navigationTitle("Your Liked Songs")
            .navigationDestination(for: String.self) { str in
                Text("Detail \(str)")
            }
        }
    }
}

struct Page7_Previews: PreviewProvider {
    static var previews: some View {
        ArtistNavigationView()
    }
}
