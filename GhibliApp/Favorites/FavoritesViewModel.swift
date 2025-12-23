//
//  FavoritesViewModel.swift
//  GhibliApp
//
//  Created by Chiraphat Techasiri on 12/22/25.
//

import Observation
import Foundation

@Observable
class FavoritesViewModel {
    private(set) var favoritesIDs: Set<String> = []
    
    private let service: FavoriteStorage
    
    init(service: FavoriteStorage = DefaultFavoriteStorage()) {
        self.service = service
    }
    
    func load() {
        favoritesIDs = service.load()
    }
    
    private func save() {
        service.save(favoriteIDs: favoritesIDs)
    }
    
    func toggleFavorites(forID id: String) {
        if favoritesIDs.contains(id) {
            favoritesIDs.remove(id)
        } else {
            favoritesIDs.insert(id)
        }
        
        save()
    }
    
    func isFavorite(id: String) -> Bool {
        favoritesIDs.contains(id)
    }
}
