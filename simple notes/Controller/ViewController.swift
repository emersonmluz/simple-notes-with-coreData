//
//  ViewController.swift
//  do to
//
//  Created by Émerson M Luz on 07/11/22.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var notesTableView: UITableView!
    @IBOutlet weak var addNoteButton: UIButton!
    @IBOutlet weak var noteTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       setupInit()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dataModel.loadData()
    }
    
    @IBAction func addNoteButtonClick(_ sender: UIButton) {
        if noteTextField.text != nil, noteTextField.text != "" {
            if let note = noteTextField.text {
                dataModel.save(note)
                notesTableView.reloadData()
            }
        }
        view.endEditing(true)
    }
    
    func setupInit() {
        addNoteButton.layer.cornerRadius = 10
        notesTableView.delegate = self
        notesTableView.dataSource = self
        noteTextField.delegate = self
        touchScreen()
    }
    
    func touchScreen () {
        let touch = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(touch)
    }
    
    func alert (tableView: UITableView, indexPath: IndexPath) {
        let alert = UIAlertController(title: "Confirme", message: "Deseja remover essa nota?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
        alert.addAction(UIAlertAction(title: "Remover", style: .destructive) {_ in
            dataModel.delete(indexPath.row)
            self.notesTableView.deleteRows(at: [indexPath], with: .left)
            self.notesTableView.reloadData()
        })
        self.present(alert, animated: true)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        let notes = notes[indexPath.row]
        cell.textLabel?.text = String(describing: indexPath.row + 1) + " " + ((notes.value(forKey: "textNotes") as? String) ?? "")
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
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if noteTextField.text != nil, noteTextField.text != ""{
            if let note = noteTextField.text {
                dataModel.save(note)
                notesTableView.reloadData()
            }
        }
        view.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        noteTextField.text = ""
    }
}
