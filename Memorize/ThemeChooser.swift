//
//  ThemeChooser.swift
//  Memorize
//
//  Created by Пермяков Андрей on 06.02.2022.
//

import SwiftUI

class ThemeChooser: ObservableObject {
    let name: String
    private let userDefaultsKey: String
    
    @Published var themes = [EmojiMemoryGameTheme]() {
        didSet {
            saveToUserDefaults()
        }
    }
    
    init(named name: String) {
        self.name = name
        self.userDefaultsKey = "ThemeChooser:\(name)"
        restoreFromUserDefaults()
        if themes.isEmpty {
            themes = [
                EmojiMemoryGameTheme(name: "Vehicles", emojis: ["🚲", "✈️", "🚁", "🚀", "🚂", "🚘", "🚌", "🚜", "🚔", "🚛", "🏎", "🛶", "⛵️", "🛺", "🛵"],  numberOfPairsOfCards: 6, color: RGBAColor(color: .blue)),
                EmojiMemoryGameTheme(name: "Food", emojis: ["🍎", "🍌", "🍐", "🍉", "🍊", "🥝", "🍅", "🥕", "🥒", "🍑", "🍓", "🥑", "🍒", "🥦", "🍋"], numberOfPairsOfCards: 6, color: RGBAColor(color: .green)),
                EmojiMemoryGameTheme(name: "Faces", emojis: ["😀", "😇", "😅", "🧐", "😎", "😱", "🥶", "🤬", "🤯", "🤮", "🤢", "🤠", "🤑", "🤡", "😍"], numberOfPairsOfCards: 6, color: RGBAColor(color: .yellow)),
                EmojiMemoryGameTheme(name: "Sprots", emojis: ["⚽️", "🏀", "🏈", "⚾️", "🥎", "🎾", "🏉", "🏐", "🎱", "⛸", "🏏", "🏹", "🪃", "🛹", "🏑", "🏓"], numberOfPairsOfCards: 6, color: RGBAColor(color: .gray)),
                EmojiMemoryGameTheme(name: "Animals", emojis: ["🐱", "🐶", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐻‍❄️", "🐨", "🐯", "🦁", "🐮", "🐷"], numberOfPairsOfCards: 6, color: RGBAColor(color: .orange)),
                EmojiMemoryGameTheme(name: "Flags", emojis: ["🏳️", "🏴‍☠️", "🏳️‍🌈", "🇬🇭", "🇧🇭", "🇻🇳", "🇬🇧", "🇧🇳", "🚩", "🇺🇦", "🇸🇪", "🇨🇩", "🇳🇵", "🇯🇵", "🏁"], numberOfPairsOfCards: 6, color: RGBAColor(color: .black))
            ]
        }
    }
    
    private func saveToUserDefaults() {
        UserDefaults.standard.set(try? JSONEncoder().encode(themes), forKey: userDefaultsKey)
    }
    
    private func restoreFromUserDefaults() {
        if let jsonData = UserDefaults.standard.data(forKey: userDefaultsKey),
           let decodedThemes = try? JSONDecoder().decode(Array<EmojiMemoryGameTheme>.self, from: jsonData) {
            themes = decodedThemes
        }
    }
    
    // MARK: - Intents.
    func add(theme: EmojiMemoryGameTheme) {
        themes.append(theme)
    }
}
