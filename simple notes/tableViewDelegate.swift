import UIKit

extension ViewController: UITableViewDelegate {
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let trashNote =   UIContextualAction(style: .destructive, title: nil) { action, view, boolAction in
        
            let alert = UIAlertController(title: "Confirme", message: "Deseja remover essa nota?", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
            alert.addAction(UIAlertAction(title: "Remover", style: .destructive) {_ in
                self.notes.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .left)
                self.effectDeleteNotes?.play()
                tableView.reloadData()
                self.saveCache()
            })
            
            self.present(alert, animated: true)
            boolAction(true)
        }
            
        trashNote.image = UIImage(systemName: "trash")
        return UISwipeActionsConfiguration(actions: [trashNote])
    }
}

