//
//  CoreDataMovieStorage.swift
//  Database
//
//  Created by Rahmat Trinanda Pramudya Amar on 23/01/26.
//

import CoreData

public final class CoreDataMovieStorage: MovieStorage {

    private let context: NSManagedObjectContext

    public init(context: NSManagedObjectContext) {
        self.context = context
    }

    // MARK: - Fetch All
    public func data() async throws -> [MovieRecord] {
        let context = self.context

        return try await withCheckedThrowingContinuation { continuation in
            context.perform {
                do {
                    let request: NSFetchRequest<CoreDataMovieEntity> =
                        CoreDataMovieEntity.fetchRequest()

                    request.sortDescriptors = [
                        NSSortDescriptor(key: "id", ascending: false)
                    ]

                    let result = try context.fetch(request)
                    continuation.resume(returning: result.map { $0.toRecord() })
                } catch {
                    continuation.resume(throwing: error)
                }
            }
        }
    }

    // MARK: - Detail

    public func detail(id: Int) async throws -> MovieRecord? {
        let context = self.context

        return try await withCheckedThrowingContinuation { continuation in
            context.perform {
                do {
                    let request: NSFetchRequest<CoreDataMovieEntity> =
                        CoreDataMovieEntity.fetchRequest()

                    request.predicate = NSPredicate(format: "id == %d", id)
                    request.fetchLimit = 1

                    let entity = try context.fetch(request).first
                    continuation.resume(returning: entity?.toRecord())
                } catch {
                    continuation.resume(throwing: error)
                }
            }
        }
    }

    // MARK: - Add All

    public func addAll(_ movies: [MovieRecord]) async throws {
        let context = self.context

        return try await withCheckedThrowingContinuation { continuation in
            context.perform {
                do {
                    movies.forEach {
                        let entity = CoreDataMovieEntity(context: context)
                        entity.apply($0)
                    }
                    try context.save()
                    continuation.resume()
                } catch {
                    continuation.resume(throwing: error)
                }
            }
        }
    }

    // MARK: - Add Single

    public func add(_ movie: MovieRecord) async throws {
        let context = self.context

        return try await withCheckedThrowingContinuation { continuation in
            context.perform {
                do {
                    let entity = CoreDataMovieEntity(context: context)
                    entity.apply(movie)
                    try context.save()
                    continuation.resume()
                } catch {
                    continuation.resume(throwing: error)
                }
            }
        }
    }

    // MARK: - Delete

    public func delete(id: Int) async throws {
        let context = self.context

        try await withCheckedThrowingContinuation { continuation in
            context.perform {
                do {
                    let request: NSFetchRequest<CoreDataMovieEntity> =
                        CoreDataMovieEntity.fetchRequest()

                    request.predicate = NSPredicate(format: "id == %d", id)

                    let result = try context.fetch(request)
                    result.forEach(context.delete)

                    try context.save()
                    continuation.resume()
                } catch {
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
