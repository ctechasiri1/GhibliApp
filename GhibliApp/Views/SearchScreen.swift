//
//  SearchScreen.swift
//  GhibliApp
//
//  Created by Chiraphat Techasiri on 12/21/25.
//

import SwiftUI

struct SearchScreen: View {
    @State private var text: String = ""
    
    var body: some View {
        NavigationStack {
            Text("This is the search screen.")
        }
        .searchable(text: $text)
    }
}

#Preview {
    SearchScreen()
}
