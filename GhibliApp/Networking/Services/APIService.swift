//
//  APIService.swift
//  GhibliApp
//
//  Created by Chiraphat Techasiri on 10/26/25.
//

import Foundation

protocol APIService: Sendable {
    func fetchFilms() async throws -> [Film]
    func fetchPerson(from URLString: String) async throws -> Person
}
