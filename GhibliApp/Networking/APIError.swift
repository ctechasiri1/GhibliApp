//
//  APIError.swift
//  GhibliApp
//
//  Created by Chiraphat Techasiri on 10/27/25.
//

import Foundation

enum APIError: LocalizedError {
    case invalidURL
    case invalidResponse
    case decodingError(Error)
    case networkError(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            "The URL is invalid."
        case .invalidResponse:
            "Invalid response from server"
        case .decodingError(let error):
            "Failed to decode response: \(error.localizedDescription)"
        case .networkError(let error):
            "Network error: \(error.localizedDescription)"
        }
    }
}
