//
//  EmojiMemoryGameTheme.swift
//  Memorize
//
//  Created by Пермяков Андрей on 22.06.2021.
//

import Foundation

struct EmojiMemoryGameTheme: Codable, Identifiable, Hashable {
    var id = UUID()
    
    var name: String
    var emojis: [String]
    var numberOfPairsOfCards: Int
    var color: RGBAColor
    
    init(name: String, emojis: [String], numberOfPairsOfCards: Int, color: RGBAColor) {
        self.name = name
        self.emojis = emojis.sorted()
        self.numberOfPairsOfCards = numberOfPairsOfCards
        self.color = color
    }
    
    init(name: String, emojis: [String], color: RGBAColor) {
        self.init(name: name, emojis: emojis, numberOfPairsOfCards: emojis.count, color: color)
    }
    
    mutating func remove(_ emoji: String) {
        if let index = emojis.firstIndex(where: { $0 == emoji }) {
            emojis.remove(at: index)
        }
    }
}
