//
//  GhibliAppTests.swift
//  GhibliAppTests
//
//  Created by Chiraphat Techasiri on 12/14/25.
//

import Foundation
import Testing
@testable import GhibliApp

struct GhibliAppTests {
    let testFilms: [Film] = [
        Film(
            id: "2baf70d1-42bb-4437-b551-e5fed5a87abe",
            title: "Castle in the Sky",
            description: "The orphan Sheeta inherited a mysterious crystal",
            director: "Hayao Miyazaki",
            producer: "Isao Takahata",
            releaseYear: "1986",
            duration: "124",
            score: "95",
            image: "",
            bannerImage: "",
            people: []
        ),
        Film(
            id: "12cfb892-aac0-4c5b-94af-521852e46d6a",
            title: "Grave of the Fireflies",
            description: "In the latter part of World War II",
            director: "Isao Takahata",
            producer: "Toru Hara",
            releaseYear: "1988",
            duration: "89",
            score: "97",
            image: "",
            bannerImage: "",
            people: []
        ),
        Film(
            id: "58611129-2dbc-4a81-a72f-77ddfc1b1b49",
            title: "My Neighbor Totoro",
            description: "Two sisters move to the country with their father",
            director: "Hayao Miyazaki",
            producer: "Hayao Miyazaki",
            releaseYear: "1988",
            duration: "86",
            score: "93",
            image: "",
            bannerImage: "",
            people: []
        )
    ]

    @MainActor
    @Test func testInitialState() async throws {
        let testService = TestingGhibliAPIService(testFilms: testFilms)
        let viewModel = SearchFilmsViewModel(service: testService)
        
        #expect(viewModel.state.data == nil)
        
        if case .idle = viewModel.state {
            
        } else {
            Issue.record("State should be .idle initially.")
        }
    }

    @MainActor
    @Test("Search with query filters results")
    func testSearchWithQuery() async throws {
        let testService = TestingGhibliAPIService(testFilms: testFilms)
        let viewModel = SearchFilmsViewModel(service: testService)
        
        await viewModel.fetch(for: "Fireflies")
        
        #expect(viewModel.state.data?.count == 1)
        #expect(viewModel.state.data?.first?.title == "Grave of the Fireflies")
    }
    
    @MainActor
    @Test("Search result gives error")
    func testSearchWithError() async throws {
        let testService = TestingGhibliAPIService(testFilms: testFilms,
                                                  shouldThrowError: true)
        let viewModel = SearchFilmsViewModel(service: testService)
        
        await viewModel.fetch(for: "Fireflies")
        
        #expect(viewModel.state.error != nil)
    }
    
    @MainActor
    @Test("Task cancellation after API call prevents state update")
    func testCancellationAfterAPICall() async {
        let testService = TestingGhibliAPIService(testFilms: testFilms,
                                                  delayDuration: .milliseconds(100))
        let viewModel = SearchFilmsViewModel(service: testService)
        
        let task = Task {
            await viewModel.fetch(for: "tot")
        }
        
        try? await Task.sleep(for: .milliseconds(550))
        task.cancel()
        
        await task.value
        
        let fetchCount = await testService.fetchCount
        #expect(fetchCount == 1)
        
        let lastSearchQuery = await testService.lastSearchQuery
        #expect(lastSearchQuery == "tot")
        #expect(viewModel.state.error != nil)
    }
    
    @MainActor
    @Test("Test that Task is not fetching data too frequently")
    func testDebounceTiming() async {
        let testService = TestingGhibliAPIService(testFilms: testFilms,
                                                  delayDuration: .milliseconds(100))
        let viewModel = SearchFilmsViewModel(service: testService)
        
        let task = Task {
            await viewModel.fetch(for: "tot")
        }
        
        /// cancel before debounce timing of 500ms is over
        try? await Task.sleep(for: .milliseconds(450))
        task.cancel()
        
        await task.value
        
        let fetchCount = await testService.fetchCount
        #expect(fetchCount == 0)
        
        let lastSearchQuery = await testService.lastSearchQuery
        #expect(lastSearchQuery == nil)
        #expect(viewModel.state == .idle)
    }
    
    @MainActor
    @Test("Multiple rapid searches only execute the last one")
    func testDebounceWithMultipleSearches() async {
        let testService = TestingGhibliAPIService(testFilms: testFilms)
        let viewModel = SearchFilmsViewModel(service: testService)
        
        /// simulate rapid typing
        let searchQueries = ["t", "to", "tot", "toto", "totor", "totoro"]
        var tasks: [Task<Void, Never>] = []
        
        for query in searchQueries {
            /// cancel previous task
            tasks.last?.cancel()
            
            let task = Task {
                await viewModel.fetch(for: query)
            }
            
            tasks.append(task)
            
            /// small delay between key strokes
            try? await Task.sleep(for: .milliseconds(50)) /// shorter than 500me debounce rate
        }
        
        await tasks.last?.value
        let fetchCount = await testService.fetchCount
        let lastSearchQuery = await testService.lastSearchQuery
        
        #expect(fetchCount == 1, "Only final search should execute")
        #expect(lastSearchQuery == "totoro", "Should search for the final query")
        #expect(viewModel.state.data?.count == 1)
        #expect(viewModel.state.data?.first?.title == "My Neighbor Totoro")
    }
    
    @MainActor
    @Test("Multiple slow searches should execute all the requests")
    func testDebounceWithSlowMultipleSearches() async {
        let testService = TestingGhibliAPIService(testFilms: testFilms)
        let viewModel = SearchFilmsViewModel(service: testService)
        
        /// simulate rapid typing
        let searchQueries = ["tot", "totor", "totoro"]
        var tasks: [Task<Void, Never>] = []
        
        for query in searchQueries {
            /// cancel previous task
            tasks.last?.cancel()
            
            let task = Task {
                await viewModel.fetch(for: query)
            }
            
            tasks.append(task)
            
            /// small delay between key strokes
            try? await Task.sleep(for: .milliseconds(550)) /// shorter than 500me debounce rate
        }
        
        await tasks.last?.value
        let fetchCount = await testService.fetchCount
        let lastSearchQuery = await testService.lastSearchQuery
        
        #expect(fetchCount == 3, "All searches should execute")
        #expect(lastSearchQuery == "totoro", "Should search for the final query")
        #expect(viewModel.state.data?.count == 1)
        #expect(viewModel.state.data?.first?.title == "My Neighbor Totoro")
    }
}
