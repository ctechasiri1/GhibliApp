//
//  FilmListView.swift
//  GhibliApp
//
//  Created by Chiraphat Techasiri on 12/14/25.
//

import SwiftUI

struct FilmListView: View {
    var filmsViewModel: FilmListViewModel
    
    var body: some View {
        NavigationStack {
            switch filmsViewModel.state {
            case .idle:
                Text("No Films Yet")

            case .loading:
                ProgressView() {
                    Text("Loading...")
                }
            case .loaded(let films):
                List(films) { film in
                    Text(film.title)
                }
            case .error(let error):
                Text(error)
                    .foregroundStyle(Color.red)
            }
        }
        .task {
            await filmsViewModel.fetch()
        }
    }
}

#Preview {
    @State @Previewable var viewModel = FilmListViewModel(service: MockGhibliAPIService())
    
    FilmListView(filmsViewModel: viewModel)
}
