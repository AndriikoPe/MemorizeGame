//
//  ThemeChooserView.swift
//  Memorize
//
//  Created by Пермяков Андрей on 06.02.2022.
//

import SwiftUI

struct ThemeChooserView: View {
    @EnvironmentObject var themeChooser: ThemeChooser
    
    @State var gamesPlayed = [EmojiMemoryGameTheme.ID:EmojiMemoryGame]()
    @State var editMode: EditMode = .inactive
    @State var editingTheme: EmojiMemoryGameTheme? = nil
    
    var body: some View {
        NavigationView {
            List {
                ForEach(themeChooser.themes, id: \.id) { theme in
                    themeNavigationLink(for: theme)
                }
                .onDelete(perform: delete)
            }
            .navigationTitle("Memorize")
            .toolbar {
                ToolbarItem { EditButton() }
                ToolbarItem(placement: .navigation) {
                    Button {
                        let newTheme = EmojiMemoryGameTheme(name: "Unnamed", emojis: [], color: RGBAColor(color: .black))
                        themeChooser.add(theme: newTheme)
                        editingTheme = newTheme
                    } label: {
                        Text("+").font(.title)
                    }
                }
            }
            .sheet(item: $editingTheme) { theme in
                EditTheme(theme: $themeChooser.themes[theme])
                    .onChange(of: themeChooser.themes[theme]) {
                        gamesPlayed[$0.id]?.theme = $0
                    }
            }
            .environment(\.editMode, $editMode)
        }
        .navigationViewStyle(.stack)
    }
    
    func delete(at offsets: IndexSet) {
        themeChooser.themes.remove(atOffsets: offsets)
    }

    func themeNavigationLink(for theme: EmojiMemoryGameTheme) -> some View {
        NavigationLink(destination: EmojiMemoryGameView(game: getGame(for: theme))) {
            VStack(alignment: .leading) {
                Text(theme.name)
                    .font(.title)
                    .foregroundColor(editMode == .active ? .black : Color(rgbaColor: theme.color))
                Text(emojisDescription(for: theme))
                    .font(.footnote)
                    .lineLimit(1)
            }
            .gesture(editMode == .active ? editGesture(for: theme) : nil)
        }
    }
    
    func editGesture(for theme: EmojiMemoryGameTheme) -> some Gesture {
        TapGesture().onEnded {
            editingTheme = theme
        }
    }
    
    func emojisDescription(for theme: EmojiMemoryGameTheme) -> String {
        if theme.numberOfPairsOfCards == theme.emojis.count {
            return "All of \(theme.emojis.joined())"
        } else {
            return "\(theme.numberOfPairsOfCards) pairs from \(theme.emojis.joined())"
        }
    }
    
    func getGame(for theme: EmojiMemoryGameTheme) -> EmojiMemoryGame {
        if let game = gamesPlayed[theme.id] { return game }
        let game = EmojiMemoryGame(with: theme)
        gamesPlayed[theme.id] = game
        return game
    }
}

struct ThemeChooserView_Previews: PreviewProvider {
    static var previews: some View {
        ThemeChooserView()
    }
}
