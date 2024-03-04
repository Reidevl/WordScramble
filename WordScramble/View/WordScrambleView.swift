//
//  WordScrambleView.swift
//  WordScramble
//
//  Created by Reiwil Lugo on 4/3/24.
//

import SwiftUI

struct WordScrambleView: View {
    @StateObject var viewModel: ViewModel = .init()
    
    var body: some View {
        NavigationStack {
            List {
                GameTextInputView(newWord: $viewModel.newWord)
                
                GameWordsListView(usedWords: viewModel.usedWords)
            }
            .navigationTitle(viewModel.rootWord)
            .onSubmit(viewModel.addNewWord)
            .onAppear(perform: viewModel.startGame)
            .alert(viewModel.errorTitle, isPresented: $viewModel.showingError) {
            } message: {
                Text(viewModel.erroMessage)
            }
            .alert(viewModel.infoTitle, isPresented: $viewModel.showingInfo) {
            } message: {
                Text(viewModel.infoMessage)
            }
            .toolbar {
                Button("Restart") {
                    viewModel.startGame()
                }
            }
            GameScoreView(gameScore: viewModel.gameScore,scoreMessage: viewModel.showScoreInfo, openInfo: $viewModel.showingInfo)
        }
    }
}

#Preview {
    WordScrambleView()
}
