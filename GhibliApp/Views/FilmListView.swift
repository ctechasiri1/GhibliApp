//
//  FilmListView.swift
//  GhibliApp
//
//  Created by Chiraphat Techasiri on 10/25/25.
//

import SwiftUI

struct FilmListView: View {
    var viewModel: FilmsViewModel
    
    var body: some View {
        NavigationStack {
            switch viewModel.state {
                case .idle:
                    Text("No Films yet")
                case .loading:
                    ProgressView {
                        Text("Loading...")
                    }
                case .loaded(let films):
                    List(films) {
                        Text($0.title)
                    }
                case .error(let error):
                    Text(error)
                        .foregroundStyle(.pink)
            }
        }
        .task {
            await viewModel.fetch()
        }
    }
}

#Preview {
    @Previewable @State var viewModel = FilmsViewModel(service: MockAPIService())
    
    FilmListView(viewModel: viewModel)
}
