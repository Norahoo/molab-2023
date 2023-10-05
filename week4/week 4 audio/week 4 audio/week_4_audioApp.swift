//
//  week_4_audioApp.swift
//  week 4 audio
//
//  Created by 何若琪 on 10/1/23.
//


import SwiftUI

@main
struct week_4_audioApp: App {
    @StateObject var audioDJ = AudioDJ()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(audioDJ)
        }
    }
}
