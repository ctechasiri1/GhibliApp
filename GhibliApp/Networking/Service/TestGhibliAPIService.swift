//
//  TestGhibliAPIService.swift
//  GhibliApp
//
//  Created by Chiraphat Techasiri on 12/27/25.
//

import Foundation

// MARK: This is for testing only
actor TestingGhibliAPIService: GhibliAPIService {
    let testFilms: [Film]
    let shouldThrowError: Bool
    let delayDuration: Duration
    
    var fetchCount: Int = 0
    var lastSearchQuery: String? = nil
    
    init(testFilms: [Film], shouldThrowError: Bool = false, delayDuration: Duration = .zero) {
        self.testFilms = testFilms
        self.shouldThrowError = shouldThrowError
        self.delayDuration = delayDuration
    }
    
    // MARK: For protocol conformance
    func fetchFilms() async throws -> [Film] {
        if shouldThrowError {
            throw APIError.networkError(NSError(domain: "Test", code: -1))
        }
        
        if delayDuration > .zero {
            try? await Task.sleep(for: delayDuration)
        }
        
        return testFilms
    }
    
    func fetchPerson(from URLString: String) async throws -> Person {
        return Person(id: "", name: "", gender: "", age: "", eyeColor: "", hairColor: "", films: [], species: "", url: "")
    }
    
    func searchFilms(for searchTerm: String) async throws -> [Film] {
        
        self.fetchCount += 1
        self.lastSearchQuery = searchTerm
        
        if shouldThrowError {
            throw APIError.networkError(NSError(domain: "Test", code: -1))
        }
        
        if delayDuration > .zero {
            try? await Task.sleep(for: delayDuration)
        }
        
        /// throws an error if the task is cancelled
        try Task.checkCancellation()
        
        if searchTerm.isEmpty {
            return testFilms
        }
        
        return testFilms.filter { film in
            film.title.localizedCaseInsensitiveContains(searchTerm)
        }
    }
}
