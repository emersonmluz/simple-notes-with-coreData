//
//  ViewController.swift
//  do to
//
//  Created by Émerson M Luz on 07/11/22.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    @IBOutlet weak var notesTableView: UITableView!
    @IBOutlet weak var addNoteButton: UIButton!
    @IBOutlet weak var noteTextField: UITextField!
    
    var notes: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addNoteButton.layer.cornerRadius = 10
        
        notesTableView.delegate = self
        notesTableView.dataSource = self
        
        let touch = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(touch)
        // Do any additional setup after loading the view.
    }

    @IBAction func addNoteButton(_ sender: UIButton) {
        guard noteTextField.text != nil && noteTextField.text != "" else {return}
        
        notes.append(noteTextField.text!)
        noteTextField.text = ""
        
        dismissKeyboard()
        
        notesTableView.reloadData()
    }
    
    @objc func dismissKeyboard() {
        noteTextField.endEditing(true)
    }
    
}
