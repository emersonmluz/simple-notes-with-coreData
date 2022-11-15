import UIKit

extension ViewController: UITextFieldDelegate {
    
    // Action para botão return do teclado virtual do Iphone
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        addNote()
        saveCache()
        return true
    }
    
}
