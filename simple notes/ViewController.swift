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
    
    var rowNumber: Int = 0
    var rowContent: [String] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowNumber
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        
        cell.textLabel?.text = rowContent[indexPath.row]
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        okButton.layer.cornerRadius = 10
        
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }

    @IBAction func okClick(_ sender: UIButton) {
        rowNumber += 1
        if fieldContent.text != nil {
            rowContent.append(fieldContent.text!)
        }
        tableView.reloadData()
    }
    
}

