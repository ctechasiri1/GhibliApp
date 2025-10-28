//
//  FilmDetailsViewModel.swift
//  GhibliApp
//
//  Created by Chiraphat Techasiri on 10/27/25.
//

import Observation
import Foundation

@Observable
class FilmDetailsViewModel {
    var people: [Person] = []
    
    let service: APIService
    
    init(service: APIService = DefaultAPIService()) {
        self.service = service
    }
    
    func fetch(for film: Film) async {
        do {
            try await withThrowingTaskGroup(of: Person.self) { group in
                for personInfoURL in film.people {
                    group.addTask {
                        try await self.service.fetchPerson(from: personInfoURL)
                    }
                }
                for try await person in group {
                    people.append(person)
                }
            }
        } catch {
            
        }
        
        
        

    }
}

import Playgrounds

#Playground {
    let viewModel = FilmDetailsViewModel()
    
    let film = MockAPIService().fetchFilm()
    await viewModel.fetch(for: film)
    
    for person in viewModel.people {
        print(person)
    }
}
