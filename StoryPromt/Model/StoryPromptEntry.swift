import Foundation
import UIKit

class StoryPromtEntry {
    var number = 0
    var verb = ""
    var adjective = ""
    var noun = ""
    var image = UIImage(named: "object-object_box-of-books")
    var genre = StoryPrompts.Genre.scifi

    func isValid() -> Bool {
        return !(verb.isEmpty && adjective.isEmpty && noun.isEmpty)
    }
}

extension StoryPromtEntry: CustomStringConvertible {
    var description: String {
        let text = StoryPrompts.promptFor(genre: genre)
        return text.replacingOccurrences(of: "<noun>", with: noun)
            .replacingOccurrences(of: "<verb>", with: verb)
            .replacingOccurrences(of: "<number>", with: String(number))
            .replacingOccurrences(of: "<adjective>", with: adjective)
    }
}
