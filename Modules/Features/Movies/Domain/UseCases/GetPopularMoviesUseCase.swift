//
//  GetPopularMoviesUseCase.swift
//  Movies
//
//  Created by Rahmat Trinanda Pramudya Amar on 23/01/26.
//

import Foundation

public protocol GetPopularMoviesUseCase {
    func execute() async throws -> [Movie]
}

public final class DefaultGetPopularMoviesUseCase: GetPopularMoviesUseCase {

    private let repository: MovieRepository

    public init(repository: MovieRepository) {
        self.repository = repository
    }

    public func execute() async throws -> [Movie] {
        try await repository.getPopularMovies()
    }
}
