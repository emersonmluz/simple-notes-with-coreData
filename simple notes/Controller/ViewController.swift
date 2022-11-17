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
    
    let note = NotesBrain()
    var effectAddNotes: AVAudioPlayer?
    var effectDeleteNotes: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        note.notepad = UserDefaults.standard.stringArray(forKey: "notepad") ?? []
        
        addNoteButton.layer.cornerRadius = 10
        
        notesTableView.delegate = self
        notesTableView.dataSource = self
        noteTextField.delegate = self
    
        loadSounds()
        touchScreen()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addNoteButtonClick(_ sender: UIButton) {
        guard noteTextField.text != nil && noteTextField.text != "" else {return}
        dismissKeyboard()
        note.addNote(textField: noteTextField)
        effectAddNotes?.play()
        notesTableView.reloadData()
    }
    
    @objc func dismissKeyboard () {
        noteTextField.resignFirstResponder()
        //também poderia ser noteTextField.endEditing(true)
    }
    
    func touchScreen () {
        let touch = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(touch)
    }
    
    func loadSounds () {
        do {
            let addNotesPath = Bundle.main.path(forResource: "noteEffect", ofType: "wav")
            let deleteNotesPath = Bundle.main.path(forResource: "deleteEffect", ofType: "wav")
            
            try effectAddNotes = AVAudioPlayer(contentsOf: URL(fileURLWithPath: addNotesPath!))
            try effectDeleteNotes = AVAudioPlayer(contentsOf: URL(fileURLWithPath: deleteNotesPath!))
        } catch {
            print("Efeitos sonoros não encontrados")
        }
    }
    
    func alert (tableView: UITableView, indexPath: IndexPath) {
        let alert = UIAlertController(title: "Confirme", message: "Deseja remover essa nota?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
        alert.addAction(UIAlertAction(title: "Remover", style: .destructive) {_ in
            self.note.removeNote(indexPath: indexPath)
            tableView.deleteRows(at: [indexPath], with: .left)
            self.effectDeleteNotes?.play()
            tableView.reloadData()
        })
        
        self.present(alert, animated: true)
    }
    
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return note.notepad.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        
        cell.textLabel?.text = String(describing: indexPath.row + 1) + " " + note.notepad[indexPath.row]
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.minimumScaleFactor = 20
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let trashNote = UIContextualAction(style: .destructive, title: nil) { action, view, boolAction in
            
            self.alert(tableView: tableView, indexPath: indexPath)
            boolAction(true)
        }
            
        trashNote.image = UIImage(systemName: "trash")
        return UISwipeActionsConfiguration(actions: [trashNote])
    }
}

extension ViewController: UITextFieldDelegate {
    
    // Action para botão return do teclado virtual do Iphone
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        dismissKeyboard()
        note.addNote(textField: noteTextField)
        effectAddNotes?.play()
        notesTableView.reloadData()
        return true
    }
    
}
