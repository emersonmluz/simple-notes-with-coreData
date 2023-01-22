//
//  TableView.swift
//  simple notes
//
//  Created by Émerson M Luz on 22/01/23.
//

import UIKit

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
