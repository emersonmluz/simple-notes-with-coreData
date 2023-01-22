//
//  Alert.swift
//  simple notes
//
//  Created by Émerson M Luz on 22/01/23.
//

import UIKit

extension ViewController {
    func alert (tableView: UITableView, indexPath: IndexPath) {
        let alert = UIAlertController(title: "Confirme", message: "Deseja remover essa nota?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
        alert.addAction(UIAlertAction(title: "Remover", style: .destructive) {_ in
            self.removeNote(indexPath.row)
            self.notesTableView.deleteRows(at: [indexPath], with: .left)
            //self.effectDeleteNotes?.play()
            self.notesTableView.reloadData()
        })
        self.present(alert, animated: true)
    }
}
