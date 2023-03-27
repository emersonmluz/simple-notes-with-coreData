//
//  ViewController.swift
//  do to
//
//  Created by Émerson M Luz on 07/11/22.
//

import UIKit
import CoreData

final class DoItViewController: UIViewController {
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.systemYellow
        view.layer.borderWidth = 0.6
        view.layer.borderColor = UIColor.black.cgColor
        return view
    }()
    
    private lazy var noteTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = UIColor.white
        textField.layer.borderWidth = 0.6
        textField.layer.borderColor = UIColor.black.cgColor
        return textField
    }()
    
    private lazy var plusButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = UIColor.black
        button.addTarget(self, action: #selector(addNoteButtonClick(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var notesTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setComponents()
        setConstraints()
        setupInit()
    }
    
    private func setupInit() {
        view.backgroundColor = UIColor.white
        textFieldSetup()
        tableViewSetup()
        touchScreen()
        DataModel.shared.loadData()
    }
    
    private func tableViewSetup() {
        notesTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        notesTableView.delegate = self
        notesTableView.dataSource = self
    }
    
    private func textFieldSetup() {
        noteTextField.delegate = self
    }
    
    private func setComponents() {
        view.addSubview(containerView)
        containerView.addSubview(noteTextField)
        containerView.addSubview(plusButton)
        view.addSubview(notesTableView)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 80),
            
            noteTextField.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            noteTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            noteTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -50),
            noteTextField.heightAnchor.constraint(equalToConstant: 30),
            
            plusButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            plusButton.leadingAnchor.constraint(equalTo: noteTextField.trailingAnchor),
            plusButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            
            notesTableView.topAnchor.constraint(equalTo: containerView.bottomAnchor),
            notesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            notesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            notesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func touchScreen () {
        let touch = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(touch)
    }
    
    @objc private func addNoteButtonClick(_ sender: UITapGestureRecognizer) {
        addNote()
    }
    
    private func addNote() {
        guard let note = noteTextField.text, noteTextField.text != nil, noteTextField.text != "" else {return}
        DataModel.shared.save(note)
        notesTableView.reloadData()
        view.endEditing(true)
    }
    
    private func alert (tableView: UITableView, indexPath: IndexPath) {
        let alert = UIAlertController(title: "Confirme", message: "Deseja remover essa nota?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
        alert.addAction(UIAlertAction(title: "Remover", style: .destructive) {_ in
            DataModel.shared.delete(indexPath.row)
            self.notesTableView.deleteRows(at: [indexPath], with: .left)
            self.notesTableView.reloadData()
        })
        self.present(alert, animated: true)
    }
}

extension DoItViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataModel.shared.notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        let notes = DataModel.shared.notes[indexPath.row]
        cell?.textLabel?.text = String(describing: indexPath.row + 1) + " " + ((notes.value(forKey: "textNotes") as? String) ?? "")
        cell?.textLabel?.numberOfLines = 0
        cell?.textLabel?.minimumScaleFactor = 20
        return cell ?? UITableViewCell()
    }
}

extension DoItViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let trashNote = UIContextualAction(style: .destructive, title: nil) { _, _, boolAction in
            self.alert(tableView: tableView, indexPath: indexPath)
            boolAction(true)
        }
        trashNote.image = UIImage(systemName: "trash")
        return UISwipeActionsConfiguration(actions: [trashNote])
    }
}

extension DoItViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        addNote()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        noteTextField.text = ""
    }
}
