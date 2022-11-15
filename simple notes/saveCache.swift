import UIKit

extension ViewController {
    func saveCache () {
        UserDefaults.standard.set(notes, forKey: "notes")
        UserDefaults.standard.synchronize()
    }
}
