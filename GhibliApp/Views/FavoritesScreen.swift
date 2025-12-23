//
//  FavoritesScreen.swift
//  GhibliApp
//
//  Created by Chiraphat Techasiri on 12/21/25.
//

import SwiftUI

struct FavoritesScreen: View {
    let favoritesViewModel: FavoritesViewModel
    let filmsViewModel: FilmsViewModel
    
    var films: [Film] {
        return []
    }
    
    var body: some View {
        NavigationStack {
            Group {
                if films.isEmpty {
                    ContentUnavailableView("There are no favorites yet", systemImage: "heart")
                } else {
                    FilmListView(favoritesViewModel: favoritesViewModel, films: films)
                }
            }
            .navigationTitle("Favorites")
        }
    }
}

#Preview {
    FavoritesScreen(favoritesViewModel: FavoritesViewModel(service: MockFavoriteStorage()), filmsViewModel: FilmsViewModel(service: MockGhibliAPIService()))
}
