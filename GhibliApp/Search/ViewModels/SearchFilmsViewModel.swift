//
//  SearchFilmsViewModel.swift
//  GhibliApp
//
//  Created by Chiraphat Techasiri on 12/23/25.
//

import Observation
import Foundation

@Observable
class SearchFilmsViewModel {
    var state: ScreenState<[Film]> = .idle
    private var lastestSearchTerm: String = ""
    
    private let service: GhibliAPIService
    
    init(service: GhibliAPIService = DefaultGhibiliAPIService()) {
        self.service = service
    }
    
    func fetch(for searchTerm: String) async {
        self.lastestSearchTerm = searchTerm
        
        guard !searchTerm.isEmpty else {
            state = .idle
            return
        }
        
        state = .loading
        
        try? await Task.sleep(for: .milliseconds(500))
        
        guard !Task.isCancelled else { return }
        
        do {
            let films = try await service.searchFilms(for: searchTerm)
            state = .loaded(films)
        } catch {
            setError(error, for: searchTerm)
        }
    }
    
    func setError(_ error: Error, for searchTerm: String) {
        guard lastestSearchTerm == searchTerm else { return }
        
        if let error = error as? APIError {
            self.state = .error(error.errorDescription ?? "unknown error")
        } else {
            self.state = .error("unknown error")
        }
    }
    
    //MARK: For Preview
    static var example: FilmsViewModel {
        let filmsViewModel = FilmsViewModel(service: MockGhibliAPIService())
        filmsViewModel.state = .loaded([Film.example, Film.favoritesExample])
        return filmsViewModel
    }
}
