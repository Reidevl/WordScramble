//
//  GameTextInputView.swift
//  WordScramble
//
//  Created by Reiwil Lugo on 4/3/24.
//

import SwiftUI

struct GameTextInputView: View {
    
    @Binding var newWord: String
    
    var body: some View {
        Section {
            TextField("Enter your word", text: $newWord)
                .textInputAutocapitalization(.never)
        }
    }
}

#Preview {
    let word = Binding<String>(get: {"Test"}, set: {_ in})
    
    return Group {
        GameTextInputView(newWord: word)
    }
}
