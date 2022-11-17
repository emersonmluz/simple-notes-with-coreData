import UIKit

class NotesBrain {
    var notepad: [String] = []
    
    func addNote (textField: UITextField) {
        notepad.append(textField.text!)
        textField.text = ""
        saveCache()
    }
    
    func removeNote (indexPath: IndexPath) {
        self.notepad.remove(at: indexPath.row)
        saveCache()
    }
    
    func saveCache () {
        UserDefaults.standard.set(self.notepad, forKey: "notepad")
        UserDefaults.standard.synchronize()
    }
}
