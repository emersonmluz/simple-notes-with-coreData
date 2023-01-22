//
//  Sound.swift
//  simple notes
//
//  Created by Émerson M Luz on 22/01/23.
//

import AVFoundation

extension ViewController {
    func loadSounds () {
        do {
            let addNotesPath = Bundle.main.path(forResource: "noteEffect", ofType: "wav")
            let deleteNotesPath = Bundle.main.path(forResource: "deleteEffect", ofType: "wav")
            try effectAddNotes = AVAudioPlayer(contentsOf: URL(fileURLWithPath: addNotesPath!))
            try effectDeleteNotes = AVAudioPlayer(contentsOf: URL(fileURLWithPath: deleteNotesPath!))
        } catch let error as NSError {
            print(error)
        }
    }
}
