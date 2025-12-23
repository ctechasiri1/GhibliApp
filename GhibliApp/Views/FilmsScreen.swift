//
//  FilmsScreen.swift
//  GhibliApp
//
//  Created by Chiraphat Techasiri on 12/21/25.
//

import SwiftUI

struct FilmsScreen: View {
    let favoritesViewModel: FavoritesViewModel
    let filmsViewModel: FilmsViewModel
    
    var body: some View {
        NavigationStack {
            Group {
                switch filmsViewModel.state {
                case .idle:
                    Text("No Films Yet")
                    
                case .loading:
                    ProgressView() {
                        Text("Loading...")
                    }
                case .loaded(let films):
                    FilmListView(favoritesViewModel: favoritesViewModel, films: films)
                case .error(let error):
                    Text(error)
                        .foregroundStyle(Color.red)
                }
            }
            .navigationTitle("Ghibli Movies")
        }
        .task {
            await filmsViewModel.fetch()
        }
    }
}

#Preview {
    FilmsScreen(favoritesViewModel: FavoritesViewModel(service: MockFavoriteStorage()), filmsViewModel: FilmsViewModel(service: MockGhibliAPIService()))
}
