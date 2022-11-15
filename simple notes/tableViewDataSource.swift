import UIKit

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        
        cell.textLabel?.text = String(describing: indexPath.row + 1) + " " + notes[indexPath.row]
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.minimumScaleFactor = 20
        
        return cell
    }
}
