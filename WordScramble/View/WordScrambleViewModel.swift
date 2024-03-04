//
//  WordScrambleViewModel.swift
//  WordScramble
//
//  Created by Reiwil Lugo on 4/3/24.
//

import Foundation
import SwiftUI

class ViewModel: ObservableObject {
    
    let letterScores: [Character: Int] = [
        "A": 1, "B": 3, "C": 3, "D": 2, "E": 1, "F": 4, "G": 2, "H": 4, "I": 1,
        "J": 8, "K": 5, "L": 1, "M": 3, "N": 1, "O": 1, "P": 3, "Q": 10, "R": 1,
        "S": 1, "T": 1, "U": 1, "V": 4, "W": 4, "X": 8, "Y": 4, "Z": 10
    ]
    
    @Published var gameScore = 0
    @Published var usedWords = [String]()
    @Published var rootWord = ""
    @Published var newWord = ""
    
    @Published var errorTitle = ""
    @Published var erroMessage = ""
    @Published var showingError = false
    
    // Score Info
    @Published var infoTitle = "Letters value"
    @Published var infoMessage = ""
    @Published var showingInfo = false
    
    // Calculate user score based on word and its letter score
    func calculateWordScore(_ word: String) -> Int {
        return word.uppercased().reduce(0) { $0 + (letterScores[$1] ?? 0) }
    }
    
    // Add new word and validate error cases
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard answer.count > 0 else { return }
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original!")
            return
        }
        
        guard isPosible(word: answer) else {
            wordError(title: "Word not posible", message: "You can't spell that word from '\(rootWord)'!")
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "Word not recognized", message: "You can't just make them up")
            return
        }
        
        guard shortWords(word: answer) else {
            wordError(title: "Word is short", message: "Word length must be greater than 3")
            return
        }
        
        guard startedWord(word: answer) else {
            wordError(title: "Same as root", message: "Word can not be the same of root word")
            return
        }
        
        gameScore += calculateWordScore(answer)
        
        withAnimation {
            usedWords.insert(answer, at: 0)
        }
        
        newWord = ""
    }
    
    // Start the game
    func startGame() {
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "silkworm"
                usedWords = []
                gameScore = 0
                return
            }
        }
        
        fatalError("Could not load start.txt from bundle.")
    }
    
    // MARK: Validating methods
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPosible(word: String) -> Bool {
        var tempWord = rootWord
        
        for letter in word {
            if let pos =  tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        
        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        erroMessage = message
        showingError = true
    }
    
    func shortWords(word: String) -> Bool {
        word.count > 3
    }
    
    func startedWord(word: String) -> Bool {
        let tempWord = rootWord
        
        return word != tempWord
    }
    
    // Show Score Info
    func showScoreInfo() {
        var message = ""
        for (letter, score) in letterScores {
            message += "\(letter): \(score)\n"
        }
        
        infoMessage = message
    }
}
