import Foundation
import UIKit

class ResultViewController: UIViewController {
    @IBOutlet var resultTextView: UITextView!
    
    var resultStoryPrompt: StoryPromtEntry?
    var isNewStoryPrompt = false
    
    override func viewDidLoad() {
        
        resultTextView.text = resultStoryPrompt?.description
        if isNewStoryPrompt {
            let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveStoryPrompt))
            let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonPressed))
            navigationItem.rightBarButtonItem = saveButton
            navigationItem.leftBarButtonItem = cancelButton
        }
    }
    
    @objc func cancelButtonPressed() {
        performSegue(withIdentifier: "CancelStoryPrompt", sender: nil)
    }
    
    @objc func saveStoryPrompt() {
        performSegue(withIdentifier: "SaveButtonPressed", sender: nil)
    }
    
    
}
