//
//  MovieLocalDataSource.swift
//  Movies
//
//  Created by Rahmat Trinanda Pramudya Amar on 23/01/26.
//

import Database

public final class MovieLocalDataSource {
    private let storage: MovieStorage

    public init(storage: MovieStorage) {
        self.storage = storage
    }

    func getMovies() async throws -> [MovieRecord] {
        try await storage.data()
    }

    func save(_ records: [MovieRecord]) async throws {
        try await storage.addAll(records)
    }
}
