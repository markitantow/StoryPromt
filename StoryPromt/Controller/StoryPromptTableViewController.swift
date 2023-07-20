import UIKit

class StoryPromptTableViewController: UITableViewController {
    var storyPrompts = StoryPromtEntry()
    var promptsText = [String]()
    var cellImage: UIImage?
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        promptsText.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StoryPromptCell", for: indexPath)
        cell.textLabel?.text = "Prompt number \(indexPath.row + 1)"
        cell.imageView?.image = cellImage
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyPrompt = promptsText[indexPath.row]
        performSegue(withIdentifier: "ShowStoryPrompt", sender: storyPrompt)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowStoryPrompt" {
            guard let resultViewController = segue.destination as? ResultViewController,
                  let promptText = sender as? String
            else {
                return
            }
            resultViewController.resultPromptText = promptText
        }
    }

    @IBAction func saveStoryPrompt(unwindSegue: UIStoryboardSegue) {
        guard let resultViewController = unwindSegue.source as? ResultViewController,
              let promptText = resultViewController.resultPromptText,
              let resultImage = resultViewController.resultImage
        else {
            return
        }
        promptsText.append(promptText)
        cellImage = resultImage
        tableView.reloadData()
    }

    @IBAction func cancelButtonPressed(unwindSegue: UIStoryboardSegue) {}
}
