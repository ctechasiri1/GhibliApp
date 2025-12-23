//
//  MockFavoriteStorage.swift
//  GhibliApp
//
//  Created by Chiraphat Techasiri on 12/22/25.
//

import Foundation

struct MockFavoriteStorage: FavoriteStorage {
    func load() -> Set<String> {
        ["2baf70d1-42bb-4437-b551-e5fed5a87abe"]
    }
    
    /// Leaving empty because don't need to mock this
    func save(favoriteIDs: Set<String>) { }
}
