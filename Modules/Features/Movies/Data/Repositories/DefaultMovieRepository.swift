//
//  DefaultMovieRepository.swift
//  Movies
//
//  Created by Rahmat Trinanda Pramudya Amar on 23/01/26.
//

import Foundation

public final class DefaultMovieRepository: MovieRepository {

    private let api: MovieAPI
    private let local: MovieLocalDataSource

    public init(api: MovieAPI, local: MovieLocalDataSource) {
        self.api = api
        self.local = local
    }

    public func getPopularMovies() async throws -> [Movie] {
        let cached = try await local.getMovies()
        if !cached.isEmpty {
            return cached.map(MovieMapper.fromRecord)
        }

        let response = try await api.fetchPopular()

        let movies = response.results.map {
            MovieMapper.toDomain(dto: $0)
        }

        try await local.save(movies.map(MovieMapper.toRecord))

        return movies
    }
}
