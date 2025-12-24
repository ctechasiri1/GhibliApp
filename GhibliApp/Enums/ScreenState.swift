//
//  ScreenState.swift
//  GhibliApp
//
//  Created by Chiraphat Techasiri on 12/23/25.
//

import Foundation

enum ScreenState<T> {
    case idle
    case loading
    case loaded(T)
    case error(String)
    
    var isLoading: Bool {
        if case .loading = self { return true }
        return false
    }
    
    var data: T? {
        if case .loaded(let value) = self { return value }
        return nil
    }
    
    var error: String? {
        if case .error(let error) = self { return error }
        return nil
    }
}
