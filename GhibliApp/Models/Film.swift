//
//  Film.swift
//  GhibliApp
//
//  Created by Chiraphat Techasiri on 12/14/25.
//

import Foundation

nonisolated // opted out of @MainActor
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
    @MainActor
    static var example: Film {
    //MockGhibliAPIService().fetchFilm()
        let bannerURL = URL.convertAssetImage(named: "bannerImage")
        let posterURL = URL.convertAssetImage(named: "posterImage")
        
        return Film(id: "2baf70d1-42bb-4437-b551-e5fed5a87abe",
                    title: "Castle in the Sky",
                    description: "The orphan Sheeta inherited a mysterious crystal that links her to the mythical sky-kingdom of Laputa.",
                    director: "Hayao Miyazaki",
                    producer: "Isao Takahata",
                    releaseYear: "1986",
                    duration: "124",
                    score: "95",
                    image: posterURL?.absoluteString ?? "",
                    bannerImage: bannerURL?.absoluteString ?? "",
                    people: ["https://ghibliapi.vercel.app/people/267649ac-fb1b-11eb-9a03-0242ac130003"])
    }
    
    @MainActor
    static var favoritesExample: Film {
    //MockGhibliAPIService().fetchFilm()
        let bannerURL = URL.convertAssetImage(named: "bannerImage2")
        let posterURL = URL.convertAssetImage(named: "posterImage2")
        
        return Film(id: "12cfb892-aac0-4c5b-94af-521852e46d6a",
                    title: "Grave of the Fireflies",
                    description: "In the latter part of World War II, a boy and his sister, orphaned when their mother is killed in the firebombing of Tokyo, are left to survive on their own in what remains of civilian life in Japan.",
                    director: "Isao Takahata",
                    producer: "Toru Hara",
                    releaseYear: "1988",
                    duration: "89",
                    score: "97",
                    image: posterURL?.absoluteString ?? "",
                    bannerImage: bannerURL?.absoluteString ?? "",
                    people: ["https://ghibliapi.vercel.app/people/267649ac-fb1b-11eb-9a03-0242ac130003"])
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
