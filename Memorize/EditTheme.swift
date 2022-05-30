//
//  EditTheme.swift
//  Memorize
//
//  Created by Пермяков Андрей on 07.02.2022.
//

import SwiftUI

struct EditTheme: View {
    @Binding var theme: EmojiMemoryGameTheme
    
    @State private var color: Color
    
    init(theme: Binding<EmojiMemoryGameTheme>) {
        _theme = theme
        _color = State(initialValue: Color(rgbaColor: theme.wrappedValue.color))
    }
    
    @State var emojisToAdd: String = ""
    
    var body: some View {
        Form {
            nameSection
            removeEmojisSection
            addEmojisSection
            numberOfPairsChooserSection
            colorPickerSection
        }
    }
    
    var nameSection: some View {
        Section(header: Text("Theme Name")) {
            TextField("Name", text: $theme.name)
        }
    }
    
    var removeEmojisSection: some View {
        Section(header: Text("Emojis")) {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: DrawingConstants.removeEmojisMinGridSize))], spacing: 0) {
                    ForEach(theme.emojis, id: \.self) { emoji in
                        Text(emoji)
                            .font(.title)
                            .onTapGesture {
                                withAnimation { remove(emoji) }
                            }
                    }
                }
            }
        }
    }
    
    var addEmojisSection: some View {
        Section(header: Text("Add Emoji")) {
            TextField("Emoji", text: $emojisToAdd)
                .onSubmit {
                    withAnimation {
                        addEmojis()
                    }
                }
        }
    }
    
    var numberOfPairsChooserSection: some View {
        Section(header: Text("Number of pairs")) {
            Stepper(value: $theme.numberOfPairsOfCards, in: 0...theme.emojis.count) {
                Text("\(theme.numberOfPairsOfCards) pairs")
            }
        }
    }
    
    var colorPickerSection: some View {
        Section(header: Text("Color")) {
            ColorPicker("Color: ", selection: $color)
                .onChange(of: color) { newValue in
                    theme.color = RGBAColor(color: newValue)
                }
        }
    }
    
    private func addEmojis() {
        if !emojisToAdd.isEmpty {
            theme.emojis = Array(Set(theme.emojis + emojisToAdd
                                .filter { $0.isEmoji }
                                .map { String($0) })).sorted()
            emojisToAdd = ""
        }
    }
    
    private func remove(_ emoji: String) {
        theme.remove(emoji)
    }
    
    private struct DrawingConstants {
        static let removeEmojisMinGridSize: CGFloat = 40.0
    }
}
