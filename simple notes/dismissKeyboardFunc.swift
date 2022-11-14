import UIKit

extension ViewController {
    
    @objc func dismissKeyboard() {
        noteTextField.resignFirstResponder()
        //também poderia ser noteTextField.endEditing(true)
    }
    
}
