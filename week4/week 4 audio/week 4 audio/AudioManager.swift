//
//  AudioManager.swift
//  week 4 audio
//
//  Created by 何若琪 on 10/19/23.
//

import Foundation
import AVFoundation
import Combine

class AudioManager: ObservableObject {
    @Published var audioDJ = AudioDJ()

    func playAudio() {
        audioDJ.play()
    }

    func stopAudio() {
        audioDJ.stop()
    }
}
