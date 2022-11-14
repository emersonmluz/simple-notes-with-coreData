import UIKit

extension ViewController {
    
    @IBAction func addNoteButton(_ sender: UIButton) {
        guard noteTextField.text != nil && noteTextField.text != "" else {return}
        
        notes.append(noteTextField.text!)
        noteTextField.text = ""
        
        dismissKeyboard()
        effectAddNotes?.play()
        notesTableView.reloadData()
    }
    
}
