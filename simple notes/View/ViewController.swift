//
//  ViewController.swift
//  do to
//
//  Created by Émerson M Luz on 07/11/22.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var notesTableView: UITableView!
    @IBOutlet weak var addNoteButton: UIButton!
    @IBOutlet weak var noteTextField: UITextField!
    
    var notes: [String] = []
    var effectAddNotes: AVAudioPlayer?
    var effectDeleteNotes: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addNoteButton.layer.cornerRadius = 10
        
        notesTableView.delegate = self
        notesTableView.dataSource = self
        
        do {
            let addNotesPath = Bundle.main.path(forResource: "noteEffect", ofType: "wav")
            let deleteNotesPath = Bundle.main.path(forResource: "deleteEffect", ofType: "wav")
            
            try effectAddNotes = AVAudioPlayer(contentsOf: URL(fileURLWithPath: addNotesPath!))
            try effectDeleteNotes = AVAudioPlayer(contentsOf: URL(fileURLWithPath: deleteNotesPath!))
        } catch {
            print("Efeitos sonoros não encontrados")
        }
        
        let touch = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(touch)
        // Do any additional setup after loading the view.
    }

    @IBAction func addNoteButton(_ sender: UIButton) {
        guard noteTextField.text != nil && noteTextField.text != "" else {return}
        
        notes.append(noteTextField.text!)
        noteTextField.text = ""
        
        dismissKeyboard()
        effectAddNotes?.play()
        notesTableView.reloadData()
    }
    
    @objc func dismissKeyboard() {
        noteTextField.endEditing(true)
    }
    
}
