//
//  DataModel.swift
//  simple notes
//
//  Created by Émerson M Luz on 22/01/23.
//

import UIKit
import CoreData

extension ViewController {
    func loadDataModel() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Notes")
        do {
            notes = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print(error)
        }
    }
    
    func save(_ note: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Notes", in: managedContext)!
        let postIt = NSManagedObject(entity: entity, insertInto: managedContext)
        postIt.setValue(note, forKey: "textNotes")
        do {
            try managedContext.save()
            notes.append(postIt)
        } catch let error as NSError {
            print(error)
        }
        //effectAddNotes?.play()
        notesTableView.reloadData()
    }
    
    func removeNote(_ row: Int) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        do {
            managedContext.delete(notes[row])
            notes.remove(at: row)
            try managedContext.save()
        } catch let error as NSError {
            print(error)
        }
    }
}
