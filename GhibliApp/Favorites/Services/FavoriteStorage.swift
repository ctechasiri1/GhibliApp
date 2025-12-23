//
//  FavoriteStorage.swift
//  GhibliApp
//
//  Created by Chiraphat Techasiri on 12/22/25.
//

import Foundation

protocol FavoriteStorage {
    func load() -> Set<String>
    func save(favoriteIDs: Set<String>) 
}
