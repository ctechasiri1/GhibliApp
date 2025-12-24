//
//  MockFavoriteStorage.swift
//  GhibliApp
//
//  Created by Chiraphat Techasiri on 12/22/25.
//

import Foundation

struct MockFavoriteStorage: FavoriteStorage {
    func load() -> Set<String> {
        ["12cfb892-aac0-4c5b-94af-521852e46d6a"]
    }
    
    /// Leaving empty because don't need to mock this
    func save(favoriteIDs: Set<String>) { }
}
