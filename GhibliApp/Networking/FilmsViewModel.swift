//
//  FilmsViewModel.swift
//  GhibliApp
//
//  Created by Chiraphat Techasiri on 10/25/25.
//

import Foundation
import Observation

@Observable
class FilmsViewModel {
    
    var films: [Film] = []
    
    func fetchFilms() async {
        guard let url = URL(string: "https://ghibliapi.vercel.app/films") else {
            print("There was trouble fetching the films.")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            films = try JSONDecoder().decode([Film].self, from: data)
        } catch {
            print(error)
        }
    }
}
