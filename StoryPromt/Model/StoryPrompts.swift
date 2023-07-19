import Foundation

class StoryPrompts {
    enum Genre: Int {
        case scifi, horror
    }

    static func promptFor(genre: Genre) -> String {
        let prompts = stubs[genre.rawValue]
        return prompts[Int.random(in: 0 ..< prompts.count)]
    }

    static var stubs = [
        [
            " The <adjective> legion, a horrific cut led by a cyborg <noun>, <verb> <number> missles at Earth",
            "Harid Ryder is a half human, half <noun>. He <verb> the last remaining <noun> in a <adjective> quest before the sun explodes in <number> days.",
            "Axel is <noun> who hacks into a <adjective> agency. In it, he <verb> a secret plot to lace <number> hotdogs with <noun> dust."
        ],
        ["Unknown to the camp counselers, a <adjective> <noun> stalks their camp. The <noun> <verb> them one at a time until only <number> remain",
         "At night, Timmy sees a <adjective> <noun> that no one else can see. Timmy <verb> crazy so he confronts the <noun> in the dead of night."]
    ]
}
