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
    
    var body: some View {
        ScrollView {
            VStack {
                FilmImageView(urlString: film.bannerImage)
                    .frame(height: 300)
                    .containerRelativeFrame(.horizontal)
                
                VStack(alignment: .leading) {
                    
                    Text(film.title)
                    
                    Text("Characters")
                    
                    Divider()
                    
                    switch viewModel.state {
                    case .idle:
                        Text("No Films Yet")
                    case .loading:
                        ProgressView() {
                            Text("Loading...")
                        }
                    case .loaded(let people):
                        ForEach(people) { person in
                            Text(person.name)
                        }
                    case .error(let error):
                        Text(error)
                            .foregroundStyle(Color.red)
                    }
                }
                .padding()
            }
        }
        .task {
            await viewModel.fetch(for: film)
        }
    }
}

#Preview {
    FilmDetailScreen(film: Film.example, favoritesViewModel: FavoritesViewModel(service: MockFavoriteStorage()))
}
