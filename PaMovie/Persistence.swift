//
//  Persistence.swift
//  PaMovie
//
//  Created by Rahmat Trinanda Pramudya Amar on 22/01/26.
//

import CoreData
import Database

public struct PersistenceController {

    public static let shared = PersistenceController()

    public let container: NSPersistentContainer

    public init(inMemory: Bool = false) {

        let modelName = "PaMovie"

        let bundle = Bundle(for: CoreDataMovieEntity.self)

        guard
            let modelURL = bundle.url(
                forResource: modelName,
                withExtension: "momd"
            ),
            let model = NSManagedObjectModel(contentsOf: modelURL)
        else {
            fatalError("❌ Failed to load CoreData model from CoreDatabase bundle")
        }

        container = NSPersistentContainer(
            name: modelName,
            managedObjectModel: model
        )

        if inMemory {
            container.persistentStoreDescriptions.first?.url =
            URL(fileURLWithPath: "/dev/null")
        }

        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Unresolved Core Data error \(error)")
            }
        }

        container.viewContext.mergePolicy =
        NSMergeByPropertyObjectTrumpMergePolicy
    }
}
