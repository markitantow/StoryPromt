import PhotosUI
import UIKit

class PromptEditingViewController: UIViewController {
    @IBOutlet var storyPromptImageView: UIImageView!
    @IBOutlet var nounTextField: UITextField!
    @IBOutlet var verbTextField: UITextField!
    @IBOutlet var adjectiveTextField: UITextField!
    @IBOutlet var numberSlider: UISlider!
    @IBOutlet var numberLabel: UILabel!
    
    let storyPrompt = StoryPromtEntry()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        numberSlider.value = 7.5
        storyPrompt.number = Int(numberSlider.value)
        storyPromptImageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(changeImage))
        storyPromptImageView.addGestureRecognizer(gestureRecognizer)
        print(storyPrompt)
    }
    
    @IBAction func changeNumber(_ sender: UISlider) {
        numberLabel.text = "Number: \(Int(sender.value))"
        storyPrompt.number = Int(sender.value)
    }
    
    @IBAction func changeStorytype(_ sender: UISegmentedControl) {
        if let genre = StoryPrompts.Genre(rawValue: sender.selectedSegmentIndex) {
            storyPrompt.genre = genre
        } else {
            storyPrompt.genre = .scifi
        }
    }
    
    func updateStoryPrompt() {
        storyPrompt.noun = nounTextField.text ?? ""
        storyPrompt.adjective = adjectiveTextField.text ?? ""
        storyPrompt.verb = verbTextField.text ?? ""
    }
    
    @IBAction func generateStoryPrompt(_ sender: UIButton) {
        updateStoryPrompt()
        if storyPrompt.isValid() {
            performSegue(withIdentifier: "resultSegue", sender: self)
        } else {
            let alert = UIAlertController(title: "Invalid Story Prompt", message: "Please fill out all of the fields", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default)
            alert.addAction(action)
            present(alert, animated: true)
        }
    }
    
    @objc func changeImage() {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 1
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "resultSegue" {
            guard let destinationVC = segue.destination as? ResultViewController else {
                return
            }
            destinationVC.resultStoryPrompt = storyPrompt
            destinationVC.isNewStoryPrompt = true
        }
    }
}

extension PromptEditingViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        updateStoryPrompt()
        return true
    }
}

extension PromptEditingViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true, completion: nil)
            
        guard let result = results.first else {
            // Пользователь не выбрал ни одного изображения
            return
        }
             
        let itemProvider = result.itemProvider
        if itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, _ in
                guard let image = image as? UIImage else {
                    return
                }
                        
                DispatchQueue.main.async {
                    self?.storyPromptImageView.image = image
                }
            }
        }
    }
}
