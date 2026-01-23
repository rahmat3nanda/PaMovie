//
//  CoreDataStorage.swift
//  Database
//
//  Created by Rahmat Trinanda Pramudya Amar on 23/01/26.
//

import CoreData

public final class CoreDataStorage: MovieStorage {

    private let context: NSManagedObjectContext

    public init(context: NSManagedObjectContext = CoreDataStack.shared.context) {
        self.context = context
    }

    public func fetchAll() async throws -> [MovieRecord] {
        let request = CoreDataMovieEntity.fetchRequest()
        let result = try context.fetch(request)
        return result.map { $0.toRecord() }
    }

    public func fetch(id: Int) async throws -> MovieRecord? {
        let request = CoreDataMovieEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", id)
        request.fetchLimit = 1

        return try context.fetch(request).first?.toRecord()
    }

    public func save(_ movie: MovieRecord) async throws {
        let request = CoreDataMovieEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", movie.id)

        let entity = try context.fetch(request).first ?? CoreDataMovieEntity(context: context)
        entity.update(from: movie)

        try context.save()
    }

    public func delete(id: Int) async throws {
        let request = CoreDataMovieEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", id)

        let entities = try context.fetch(request)
        entities.forEach(context.delete)

        try context.save()
    }
}
