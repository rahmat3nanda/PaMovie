//
//  CoreDataMovieEntity.swift
//  Database
//
//  Created by Rahmat Trinanda Pramudya Amar on 23/01/26.
//

import Foundation
import CoreData

@objc(CoreDataMovieEntity)
public final class CoreDataMovieEntity: NSManagedObject {
    @NSManaged public var id: Int64
    @NSManaged public var title: String
    @NSManaged public var overview: String
    @NSManaged public var posterPath: String?
    @NSManaged public var isFavorite: Bool
}

extension CoreDataMovieEntity {
    func toRecord() -> MovieRecord {
        MovieRecord(
            id: Int(id),
            title: title,
            overview: overview,
            posterPath: posterPath,
            isFavorite: isFavorite
        )
    }

    func apply(_ record: MovieRecord) {
        id = Int64(record.id)
        title = record.title
        overview = record.overview
        posterPath = record.posterPath
        isFavorite = record.isFavorite
    }
}

extension CoreDataMovieEntity {
    @nonobjc
    class func fetchRequest() -> NSFetchRequest<CoreDataMovieEntity> {
        NSFetchRequest<CoreDataMovieEntity>(entityName: "CoreDataMovieEntity")
    }
}
