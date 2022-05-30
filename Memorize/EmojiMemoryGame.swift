//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Пермяков Андрей on 20.06.2021.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    typealias Card = MemoryGame<String>.Card
    
    var theme: EmojiMemoryGameTheme {
        didSet { restart() }
    }
    
    private static func createMemoryGame(with theme: EmojiMemoryGameTheme) -> MemoryGame<String> {
        let emojis = theme.emojis.shuffled()
        let numberOfPairsOfCards = theme.numberOfPairsOfCards < emojis.count ?
            theme.numberOfPairsOfCards : emojis.count
        return MemoryGame<String>(numberOfPairsOfCards: numberOfPairsOfCards) { pairIndex in
            emojis[pairIndex]
        }
    }
    
    @Published private var model: MemoryGame<String>
        
    var cards: [Card] {
        model.cards
    }
    
    var color: Color {
        Color(rgbaColor: theme.color)
    }
    
    var title: String {
        theme.name
    }
    
    var score: Int {
        model.score
    }
    
    init(with theme: EmojiMemoryGameTheme) {
        self.theme = theme
        model = EmojiMemoryGame.createMemoryGame(with: theme)
    }
    
    // MARK: - Intents
    
    func choose(_ card: Card) {
        model.choose(card)
    }
    
    func restart() {
//        theme = EmojiMemoryGame.createTheme()
        model = EmojiMemoryGame.createMemoryGame(with: theme)
    }
    
    func shuffle() {
        model.shuffle()
    }
}
