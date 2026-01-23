//
//  MovieStorage.swift
//  Database
//
//  Created by Rahmat Trinanda Pramudya Amar on 23/01/26.
//

import Foundation

public protocol MovieStorage {
    func data() async throws -> [MovieRecord]
    func detail(id: Int) async throws -> MovieRecord?
    func addAll(_ movies: [MovieRecord]) async throws
    func add(_ movie: MovieRecord) async throws
    func delete(id: Int) async throws
}
