//
//  FilmDetailsViewModel.swift
//  GhibliApp
//
//  Created by Chiraphat Techasiri on 12/14/25.
//

import Observation
import Foundation

@Observable
class FilmDetailsViewModel {
    var state: ScreenState<[Person]> = .idle
    
    private let service: GhibliAPIService
    
    init(service: GhibliAPIService = DefaultGhibiliAPIService()) {
        self.service = service
    }
    
    func fetch(for film: Film) async {
        guard !state.isLoading else { return }
        
        state = .loading
        
        do {
            var loadedPeople: [Person] = []
            try await withThrowingTaskGroup(of: Person.self) { group in
                for personInfoURL in film.people {
                    group.addTask {
                        try await self.service.fetchPerson(from: personInfoURL)
                    }
                }
                ///collect results as they complete
                for try await person in group {
                    loadedPeople.append(person)
                }
            }
            
            state = .loaded(loadedPeople)
            
        } catch let error as APIError {
            self.state = .error(error.errorDescription ?? "unknown error")
        } catch {
            self.state = .error("unknown error")
        }
    }
}

import Playgrounds

#Playground {
    let service = MockGhibliAPIService()
    let viewModel = FilmDetailsViewModel(service: service)
    
    let film = service.fetchFilm()
    try await viewModel.fetch(for: film)
    
    switch viewModel.state {
    case .idle:
        print("Idle State")
    case .loading:
        print("Loading State")
    case .loaded(let people):
        for person in people {
            print(person)
        }
    case .error(let error):
        print("Error State")
    }
}

