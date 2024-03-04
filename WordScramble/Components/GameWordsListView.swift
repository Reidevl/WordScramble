//
//  GameWordsListView.swift
//  WordScramble
//
//  Created by Reiwil Lugo on 4/3/24.
//

import SwiftUI

struct GameWordsListView: View {
    var usedWords: [String]
    
    var body: some View {
        Section {
            ForEach(usedWords, id: \.self) { word in
                HStack {
                    Image(systemName: "\(word.count).circle")
                    Text(word.capitalized)
                }
            }
        }
    }
}

#Preview {
    GameWordsListView(usedWords: ["Test1", "Testing2"])
}
