//
//  TextField.swift
//  simple notes
//
//  Created by Émerson M Luz on 22/01/23.
//

import UIKit

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if noteTextField.text != nil, noteTextField.text != ""{
            if let note = noteTextField.text {
                save(note)
            }
        }
        view.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        noteTextField.text = ""
    }
}
