//
//  FavoriteButton.swift
//  GhibliApp
//
//  Created by Chiraphat Techasiri on 12/23/25.
//
import SwiftUI

struct FavoriteButton: View {
    let filmID: String
    let favoritesViewModel: FavoritesViewModel
    
    var isFavorite: Bool {
        favoritesViewModel.isFavorite(id: filmID)
    }
    
    var body: some View {
        Button {
            favoritesViewModel.toggleFavorites(forID: filmID)
        } label: {
            Image(systemName: isFavorite ? "heart.fill" : "heart")
                .foregroundStyle(isFavorite ? .pink : .secondary)
        }
    }
}
