//
//  ViewController.swift
//  do to
//
//  Created by Émerson M Luz on 07/11/22.
//

import UIKit
import AVFoundation
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var notesTableView: UITableView!
    @IBOutlet weak var addNoteButton: UIButton!
    @IBOutlet weak var noteTextField: UITextField!
    
    var notes: [NSManagedObject] = []
    var effectAddNotes: AVAudioPlayer?
    var effectDeleteNotes: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       setupInit()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadDataModel()
    }
    
    @IBAction func addNoteButtonClick(_ sender: UIButton) {
        if noteTextField.text != nil, noteTextField.text != "" {
            if let note = noteTextField.text {
                save(note)
            }
        }
        view.endEditing(true)
    }
    
    func setupInit() {
        addNoteButton.layer.cornerRadius = 10
        notesTableView.delegate = self
        notesTableView.dataSource = self
        noteTextField.delegate = self
       // loadSounds()
        touchScreen()
    }
    
    func touchScreen () {
        let touch = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(touch)
    }
}
