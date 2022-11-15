import UIKit

extension ViewController {
    
    func alert (tableView: UITableView, indexPath: IndexPath) {
        let alert = UIAlertController(title: "Confirme", message: "Deseja remover essa nota?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
        alert.addAction(UIAlertAction(title: "Remover", style: .destructive) {_ in
            self.removeNote(tableView: tableView, indexPath: indexPath)
        })
        
        self.present(alert, animated: true)
    }
}
