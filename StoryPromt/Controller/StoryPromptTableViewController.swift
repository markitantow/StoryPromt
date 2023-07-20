import UIKit

class StoryPromptTableViewController: UITableViewController {
    var storyPrompts = [StoryPromtEntry]()
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        storyPrompts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StoryPromptCell", for: indexPath)
        cell.textLabel?.text = "Prompt number \(indexPath.row + 1)"
        cell.imageView?.image = storyPrompts[indexPath.row].image
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(storyPrompts)
        let storyPrompt = storyPrompts[indexPath.row]
        print(storyPrompt)
        performSegue(withIdentifier: "ShowStoryPrompt", sender: storyPrompt)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowStoryPrompt" {
            guard let resultViewController = segue.destination as? ResultViewController,
                  let storyPrompt = sender as? StoryPromtEntry else {
                return
            }
            resultViewController.resultStoryPrompt = storyPrompt
        }
    }
    
    @IBAction func saveStoryPrompt(unwindSegue: UIStoryboardSegue) {
        guard let resultViewController = unwindSegue.source as? ResultViewController,
              let storyPrompt = resultViewController.resultStoryPrompt else {
            return
        }
        print("После нажатия save \(storyPrompt)")
        storyPrompts.append(storyPrompt)
        tableView.reloadData()
    }
    
    @IBAction func cancelButtonPressed(unwindSegue: UIStoryboardSegue) {
        
    }
}
