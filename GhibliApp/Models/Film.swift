//
//  Film.swift
//  GhibliApp
//
//  Created by Chiraphat Techasiri on 10/25/25.
//

import Foundation

struct Film: Codable, Identifiable, Equatable {
    let id: String
    let title: String
    let description: String
    let director: String
    let producer: String
    let score: String
    
    let releaseYear: String
    let duration: String
    
    let image: String
    let bannerImage: String
    
    let people: [String]
    
    enum CodingKeys: String, CodingKey {
        case id, title, image, description, director, producer, people
        
        case score = "rt_score"
        
        case releaseYear = "release_date"
        case duration = "running_time"
        
        case bannerImage = "movie_banner"
    }
}

import Playgrounds

#Playground {
    let url = URL(string: "https://ghibliapi.vercel.app/films")!
    
    do {
        let (data, response) = try await URLSession.shared.data(from: url)
        
        try JSONDecoder().decode([Film].self, from: data)
        
    } catch {
        print(error)
    }
}
