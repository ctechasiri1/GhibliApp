//
//  ContentView.swift
//  GhibliApp
//
//  Created by Chiraphat Techasiri on 12/14/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Tab("Films", systemImage: "movieclapper") {
                FilmsScreen()
            }
            
            Tab("Favorites", systemImage: "heart") {
                FavoritesScreen()
            }
            
            Tab("Settings", systemImage: "gear") {
                SettingsScreen()
            }
            
            Tab(role: .search) {
                SearchScreen()
            }
        }
    }
}

#Preview {
    ContentView()
}
