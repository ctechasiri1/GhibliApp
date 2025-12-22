//
//  FilmListView.swift
//  GhibliApp
//
//  Created by Chiraphat Techasiri on 12/14/25.
//

import SwiftUI

struct FilmListView: View {
    let films: [Film]
    
    var body: some View {
        List(films) { film in
            NavigationLink(value: film) {
                HStack {
                    FilmImageView(urlString: film.image)
                        .frame(width: 100, height: 150)
                    
                    Text(film.title)
                }
            }
        }
        .navigationDestination(for: Film.self) { film in
            FilmDetailScreen(film: film)
        }
    }
}

#Preview {
    FilmListView(films: FilmsViewModel(service: MockGhibliAPIService()).films)
}
