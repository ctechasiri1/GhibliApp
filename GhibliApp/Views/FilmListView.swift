//
//  FilmListView.swift
//  GhibliApp
//
//  Created by Chiraphat Techasiri on 12/14/25.
//

import SwiftUI

struct FilmListView: View {
    let favoritesViewModel: FavoritesViewModel
    let films: [Film]
    
    var body: some View {
        List(films) { film in
            NavigationLink(value: film) {
                FilmRow(film: film, favoritesViewModel: favoritesViewModel)
            }
        }
        .navigationDestination(for: Film.self) { film in
            FilmDetailScreen(film: film, favoritesViewModel: favoritesViewModel)
        }
    }
}

private struct FilmRow: View {
    let film: Film
    let favoritesViewModel: FavoritesViewModel
    
    var isFavorite: Bool {
        favoritesViewModel.isFavorite(id: film.id)
    }
    
    var body: some View {
        HStack(alignment: .top) {
            FilmImageView(urlString: film.image)
                .frame(width: 100, height: 150)
            
            VStack(alignment: .leading) {
                HStack {
                    Text(film.title)
                        .bold()
                    
                    Spacer()
                    
                    Button {
                        favoritesViewModel.toggleFavorites(forID: film.id)
                    } label: {
                        Image(systemName: isFavorite ? "heart.fill" : "heart")
                            .foregroundStyle(isFavorite ? Color.pink : Color.gray)
                    }
                    .buttonStyle(.plain)
                    .controlSize(.large)
                }
                .padding(.bottom, 5)
                
                Text(film.director)
                    .font(.subheadline)
                    .foregroundStyle(Color.secondary)
                
                Text("Released:\(film.releaseYear)")
                    .font(.caption)
                    .foregroundStyle(Color.secondary)
            }
            .padding(.top)
        }
    }
}

#Preview {
    @State @Previewable var favoritesViewModel: FavoritesViewModel = FavoritesViewModel(service: MockFavoriteStorage())
    
    NavigationStack {
        FilmListView(favoritesViewModel: favoritesViewModel, films: [Film.example])
    }
    .task {
        favoritesViewModel.load()
    }
}
