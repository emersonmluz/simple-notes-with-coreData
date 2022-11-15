import UIKit

extension ViewController {
    func addNote () {
        guard noteTextField.text != nil && noteTextField.text != "" else {return}
        notes.append(noteTextField.text!)
        noteTextField.text = ""
        dismissKeyboard()
        effectAddNotes?.play()
        notesTableView.reloadData()
        saveCache()
    }
}
