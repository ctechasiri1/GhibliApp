//
//  ContentView.swift
//  GhibliApp
//
//  Created by Chiraphat Techasiri on 12/14/25.
//

import SwiftUI

struct ContentView: View {
    @State private var filmsViewModel: FilmsViewModel = FilmsViewModel()
    
    var body: some View {
        TabView {
            Tab("Films", systemImage: "movieclapper") {
                FilmsScreen(filmsViewModel: filmsViewModel)
            }
            
            Tab("Favorites", systemImage: "heart") {
                FavoritesScreen(filmsViewModel: filmsViewModel)
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
