//
//  PopularMoviesViewModel.swift
//  Movies
//
//  Created by Rahmat Trinanda Pramudya Amar on 23/01/26.
//

import Foundation
import Combine

@MainActor
final class PopularMoviesViewModel: ObservableObject {

    // MARK: - State

    @Published var movies: [Movie] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    // MARK: - Use Case

    private let getPopularMovies: GetPopularMoviesUseCase

    // MARK: - Init

    init(getPopularMovies: GetPopularMoviesUseCase) {
        self.getPopularMovies = getPopularMovies
    }

    // MARK: - Action

    func load() async {
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }

        do {
            movies = try await getPopularMovies.execute()
        } catch {
            errorMessage = error.localizedDescription
            movies = []
        }
    }
}
