//
//  ContentView.swift
//  WordScramble
//
//  Created by Reiwil Lugo on 28/2/24.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        Text("hola")
    }
    
    
    func testBundles() {
        if let fileURL = Bundle.main.url(forResource: "somefile", withExtension: "txt") {
            if let fileContents = try? String(contentsOf: fileURL) {
                // we loaded the file into a string!
            }
        }
    }
}

#Preview {
    ContentView()
}
