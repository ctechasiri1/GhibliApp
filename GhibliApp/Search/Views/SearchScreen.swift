//
//  SearchScreen.swift
//  GhibliApp
//
//  Created by Chiraphat Techasiri on 12/21/25.
//

import SwiftUI

struct SearchScreen: View {
    let favoritesViewModel: FavoritesViewModel
    
    @State private var text: String = ""
    @State private var searchFilmsViewModel: SearchFilmsViewModel

    init(favoritesViewModel: FavoritesViewModel,
         searchFilmsViewModel: SearchFilmsViewModel = SearchFilmsViewModel(service: DefaultGhibiliAPIService())) {
        self.searchFilmsViewModel = searchFilmsViewModel
        self.favoritesViewModel = favoritesViewModel
    }
    
    var body: some View {
        NavigationStack {
            switch searchFilmsViewModel.state {
            case .idle:
                Text("Show search here")
            case .loading:
                ProgressView()
            case .loaded(let films):
                FilmListView(favoritesViewModel: favoritesViewModel,
                             films: films)
            case .error(let error):
                Text(error)
            }
        }
        .searchable(text: $text)
        .task(id: text) {
            /// changes in text will run the task
            try? await Task.sleep(for: .milliseconds(500))
            
            /// if task is not cancelled continue running, otherwise return
            guard !Task.isCancelled else { return }
            
            await searchFilmsViewModel.fetch(for: text)
        }
    }
}

#Preview {
    SearchScreen(favoritesViewModel: FavoritesViewModel(service: MockFavoriteStorage()))
}
