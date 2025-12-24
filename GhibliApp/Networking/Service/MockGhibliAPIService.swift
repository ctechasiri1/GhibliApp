//
//  MockGhibliAPIService.swift
//  GhibliApp
//
//  Created by Chiraphat Techasiri on 12/14/25.
//

import Foundation

struct MockGhibliAPIService: GhibliAPIService {
    private struct SampleData: Decodable {
        let films: [Film]
        let people: [Person]
    }
    
    private func loadSampleData() throws -> SampleData {
        guard let url = Bundle.main.url(forResource: "SampleData", withExtension: "json") else { throw APIError.invalidURL }
        
        do {
            let data = try Data(contentsOf: url)
            
            print(data)
            
            return try JSONDecoder().decode(SampleData.self, from: data)
        } catch let error as DecodingError {
            throw APIError.decoding(error)
        } catch {
            throw APIError.networkError(error)
        }
    }
    
    // MARK: For protocol conformance
    func fetchFilms() async throws -> [Film] {
        let data = try loadSampleData()
        return data.films
    }
    
    func fetchPerson(from URLString: String) async throws -> Person {
        let data = try loadSampleData()
        return data.people.first!
    }
    
    func searchFilms(for searchTerm: String) async throws -> [Film] {
        let allFilms = try await fetchFilms()
        return allFilms.filter { film in
            film.title.localizedStandardContains(searchTerm)
        }
    }
    
    // MARK: For preview/testing
    func fetchFilm() -> Film {
        let data = try! loadSampleData()
        return data.films.first!
    }
}
