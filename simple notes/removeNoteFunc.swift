import UIKit

extension ViewController {
    
    func removeNote (tableView: UITableView, indexPath: IndexPath) {
        self.notes.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .left)
        self.effectDeleteNotes?.play()
        tableView.reloadData()
        saveCache()
    }
   
}
