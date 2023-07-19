import Foundation
import UIKit

class ResultViewController: UIViewController {
    @IBOutlet var resultTextView: UITextView!
    
    var resultStoryPrompt: StoryPromtEntry?
    
    override func viewDidLoad() {
        resultTextView.text = resultStoryPrompt?.description
    }
    
    @IBAction func returnButtonPressed(_ sender: UIButton!) {
        dismiss(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
