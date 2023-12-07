//
//  ViewController.swift
//  MotionCapture
//
//  Created by 何若琪 on 11/30/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ARViewContainer()
            .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
