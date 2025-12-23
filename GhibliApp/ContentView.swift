//
//  ContentView.swift
//  GhibliApp
//
//  Created by Chiraphat Techasiri on 12/14/25.
//

import SwiftUI

struct ContentView: View {
    @State private var favoritesViewModel: FavoritesViewModel = FavoritesViewModel()
    @State private var filmsViewModel: FilmsViewModel = FilmsViewModel()
    
    var body: some View {
        TabView {
            Tab("Films", systemImage: "movieclapper") {
                FilmsScreen(favoritesViewModel: favoritesViewModel, filmsViewModel: filmsViewModel)
            }
            
            Tab("Favorites", systemImage: "heart") {
                FavoritesScreen(favoritesViewModel: favoritesViewModel, filmsViewModel: filmsViewModel)
            }
            
            Tab("Settings", systemImage: "gear") {
                SettingsScreen()
            }
            
            Tab(role: .search) {
                SearchScreen()
            }
        }
        .task {
            favoritesViewModel.load()
        }
    }
}

#Preview {
    ContentView()
}
