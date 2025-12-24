//
//  FilmsViewModel.swift
//  GhibliApp
//
//  Created by Chiraphat Techasiri on 12/14/25.
//

import Observation
import Foundation

@Observable
class FilmsViewModel {
    enum ScreenState: Equatable {
        case idle
        case loading
        case loaded([Film])
        case error(String)
    }
    
    var state: ScreenState = .idle
    
    private let service: GhibliAPIService
    
    init(service: GhibliAPIService = DefaultGhibiliAPIService()) {
        self.service = service
    }
    
    func fetch() async {
        guard state == .idle else { return }
        
        state = .loading
        
        do {
            let films = try await service.fetchFilms()
            state = .loaded(films)
        } catch let error as APIError {
            self.state = .error(error.errorDescription ?? "unknown error")
        } catch {
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
