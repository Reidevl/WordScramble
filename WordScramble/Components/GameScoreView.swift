//
//  GameScoreView.swift
//  WordScramble
//
//  Created by Reiwil Lugo on 4/3/24.
//

import SwiftUI

struct GameScoreView: View {
    var gameScore: Int
    var scoreMessage: () -> Void
    
    @Binding var openInfo: Bool
    
    var body: some View {
        
        HStack {
            Button(action: {
                scoreMessage()
                openInfo.toggle()
            }) {
                Image(systemName: "info.circle")
                    .accessibilityLabel(Text("Score Info"))
            }
            .labelsHidden()
            
            Text("Score: ^[\(gameScore) point](inflect: true)")
                .padding()
        }
        .padding()
    }
}

#Preview {
    let showScoreInfo = Binding<Bool>(get: {false}, set: {_ in})
    let scoreMessage = { print("hello") }
    
    return Group {
        GameScoreView(gameScore: 5, scoreMessage: scoreMessage, openInfo: showScoreInfo)
    }
}
