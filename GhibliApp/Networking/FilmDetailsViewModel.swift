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
    var people: [Person] = []
    
    private let service: GhibliAPIService
    
    init(service: GhibliAPIService = DefaultGhibiliAPIService()) {
        self.service = service
    }
    
    func fetch(for film: Film) async throws {
        do {
            try await withThrowingTaskGroup(of: Person.self) { group in
                for person in film.people {
                    group.addTask {
                        try await self.service.fetchPerson(from: person)
                    }
                    
                    ///collect results as they complete
                    for try await person in group {
                        people.append(person)
                    }
                }
            }
        } catch {
            
        }
    }
    
}
