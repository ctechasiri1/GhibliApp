//
//  FilmDetailScreen.swift
//  GhibliApp
//
//  Created by Chiraphat Techasiri on 12/21/25.
//

import SwiftUI

struct FilmDetailScreen: View {
    let film: Film
    let favoritesViewModel: FavoritesViewModel
    
    @State private var viewModel = FilmDetailsViewModel()
    
    var isFavorite: Bool {
        favoritesViewModel.isFavorite(id: film.id)
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 7) {
                FilmImageView(urlString: film.bannerImage)
                    .frame(height: 300)
                    .containerRelativeFrame(.horizontal)
                
                VStack(alignment: .leading, spacing: 10) {
                    
                    Text(film.title)
                        .font(.system(.title, weight: .bold))
                    
                    Grid(alignment: .leading) {
                        InfoRow(label: "Director", value: film.director)
                        InfoRow(label: "Producer", value: film.producer)
                        InfoRow(label: "Release Date", value: film.releaseYear)
                        InfoRow(label: "Running Time", value: "\(film.duration) min")
                        InfoRow(label: "Score", value: "\(film.score)/100")
                    }
                    .padding(.vertical, 8)
                    
                    Divider()
                    
                    Text("Description")
                        .font(.headline)
                    
                    Text(film.description)
                    
                    Divider()

                    CharacterSectionView(viewModel: viewModel)
                }
                .padding()
            }
        }
        .toolbar {
            FavoriteButton(filmID: film.id,
                           favoritesViewModel: favoritesViewModel)
        }
        .task {
            await viewModel.fetch(for: film)
        }
    }
}

fileprivate struct InfoRow: View {
    let label: String
    let value: String
    
    var body: some View {
        GridRow {
            Text(label)
                .font(.system(.subheadline, weight: .medium))
                .frame(width: 100, alignment: .leading)
            
            Text(value)
                .font(.subheadline)
        }
    }
}

fileprivate struct CharacterSectionView: View {
    
    let viewModel: FilmDetailsViewModel
    
    var body: some View {
        GroupBox {
            VStack(alignment: .leading) {
                Text("Character")
                    .font(.headline)
                
                switch viewModel.state {
                case .idle: EmptyView()
                case .loading: ProgressView("Loading Details...")
                case .loaded(let people):
                    ForEach(people) { person in
                        VStack(alignment: .leading, spacing: 4) {
                            Text(person.name)
                            
                            HStack(spacing: 8) {
                                Text("Age: \(person.age)")
                                
                                Spacer()
                                
                                Label(person.eyeColor, systemImage: "eye")
                                
                                Text("Hair: \(person.hairColor)")
                            }
                            .foregroundColor(.secondary)
                            .font(.caption)
                            .lineLimit(1)
                        }
                    }
                case .error(let error):
                    Text(error)
                        .foregroundStyle(Color.red)
                }
            }
        }
    }
}

#Preview {
    FilmDetailScreen(film: Film.example, favoritesViewModel: FavoritesViewModel(service: MockFavoriteStorage()))
}
