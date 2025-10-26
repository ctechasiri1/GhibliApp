//
//  Person.swift
//  GhibliApp
//
//  Created by Chiraphat Techasiri on 10/25/25.
//

import Foundation

struct Person: Codable, Identifiable {
    let id: String
    let name: String
    let gender: String
    let age: String
    let eyeColor: String
    let hairColor: String
    let films: [String]
    let species: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, gender, age, films, species, url
        case eyeColor = "eye_color"
        case hairColor = "hair_color"
    }
}


import Playgrounds

#Playground {
    let url = URL(string: "https://ghibliapi.vercel.app/people/598f7048-74ff-41e0-92ef-87dc1ad980a9")!
    
    do {
        let (data, response) = try await URLSession.shared.data(from: url)
        try JSONDecoder().decode(Person.self, from: data)
    } catch {
        print(error)
    }
}
