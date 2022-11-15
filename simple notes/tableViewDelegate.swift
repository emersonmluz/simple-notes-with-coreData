import UIKit

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

