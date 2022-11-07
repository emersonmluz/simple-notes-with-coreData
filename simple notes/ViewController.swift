//
//  ViewController.swift
//  do to
//
//  Created by Émerson M Luz on 07/11/22.
//

import UIKit
import Foundation

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var fieldContent: UITextField!
    
    var rowContent: [String] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowContent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        
        cell.textLabel?.text = String(describing: indexPath.row) + " " + rowContent[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            let removeLine =   UIContextualAction(style: .destructive, title: nil) { action, view, boolAction in
        
                tableView.performBatchUpdates {
                    self.rowContent.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .fade)
                }
        
                boolAction(true)
            }
            
            removeLine.image = UIImage(systemName: "trash")
            return UISwipeActionsConfiguration(actions: [removeLine])
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        okButton.layer.cornerRadius = 10
        
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }

    @IBAction func okClick(_ sender: UIButton) {
        guard fieldContent.text != nil && fieldContent.text != "" else {return}
        
        rowContent.append(fieldContent.text!)
        fieldContent.text = ""
        
        tableView.reloadData()
    }
    
}

