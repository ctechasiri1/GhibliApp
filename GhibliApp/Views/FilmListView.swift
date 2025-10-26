//
//  FilmListView.swift
//  GhibliApp
//
//  Created by Chiraphat Techasiri on 10/25/25.
//

import SwiftUI

struct FilmListView: View {
    @State private var viewModel: FilmsViewModel = FilmsViewModel()
    
    var body: some View {
        List(viewModel.films) {
            Text($0.title)
        }
        .task {
            await viewModel.fetchFilms()
        }
    }
}

#Preview {
    FilmListView()
}
