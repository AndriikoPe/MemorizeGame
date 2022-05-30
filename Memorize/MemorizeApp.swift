//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Пермяков Андрей on 19.06.2021.
//

import SwiftUI

@main
struct MemorizeApp: App {
//    @StateObject var game = EmojiMemoryGame()
    @StateObject var themeChooser = ThemeChooser(named: "Default")
    
    var body: some Scene {
        WindowGroup {
            ThemeChooserView()
                .environmentObject(themeChooser)
//            EmojiMemoryGameView(game: game)
        }
    }
}
