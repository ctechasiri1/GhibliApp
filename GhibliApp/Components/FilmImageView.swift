//
//  FilmImageView.swift
//  GhibliApp
//
//  Created by Chiraphat Techasiri on 12/21/25.
//

import SwiftUI

struct FilmImageView: View {
    let url: URL?
    
    init(urlString: String) {
        self.url = URL(string: urlString)
    }
    
    init(url: URL?) {
        self.url = url
    }
    
    var body: some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .empty:
                Color(white: 0.5)
                    .overlay {
                        ProgressView()
                            .controlSize(.small)
                    }
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
            case .failure(_):
                Text("Could not get image")
            @unknown default:
                fatalError()
            }
        }
    }
}


#Preview("poster image") {
    FilmImageView(url: URL.convertAssetImage(named: "posterImage"))
        .frame(height: 150)
}

#Preview("banner image") {
    FilmImageView(url: URL.convertAssetImage(named: "bannerImage"))
        .frame(height: 300)
}

