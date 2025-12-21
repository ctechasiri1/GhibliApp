//
//  Film.swift
//  GhibliApp
//
//  Created by Chiraphat Techasiri on 12/14/25.
//

import Foundation

struct Film: Codable, Identifiable, Equatable, Hashable {
    let id: String
    let title: String
    let description: String
    let director: String
    let producer: String
    
    let releaseYear: String
    let duration: String
    let score: String
    
    let image: String
    let bannerImage: String
    
    let people: [String]
    
    enum CodingKeys: String, CodingKey {
        case id, title, image, description, director, producer, people
        
        case bannerImage = "movie_banner"
        case releaseYear = "release_date"
        case duration = "running_time"
        case score = "rt_score"
    }
    
    // MARK: Preview
    static var example: Film {
        MockGhibliAPIService().fetchFilm()
    }
}


import Playgrounds

#Playground {
    if let url = URL(string: "https://ghibliapi.vercel.app/films") {
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            try JSONDecoder().decode([Film].self, from: data)
            
        } catch {
            print(error)
        }
    }
}
