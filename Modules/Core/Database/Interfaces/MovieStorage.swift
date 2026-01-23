//
//  MovieStorage.swift
//  Database
//
//  Created by Rahmat Trinanda Pramudya Amar on 23/01/26.
//

import Foundation

public protocol MovieStorage {
    func fetchAll() async throws -> [MovieRecord]
    func fetch(id: Int) async throws -> MovieRecord?
    func save(_ movie: MovieRecord) async throws
    func delete(id: Int) async throws
}
