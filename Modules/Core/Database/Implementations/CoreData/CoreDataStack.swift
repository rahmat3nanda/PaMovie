//
//  CoreDataStack.swift
//  Database
//
//  Created by Rahmat Trinanda Pramudya Amar on 23/01/26.
//

import CoreData

public final class CoreDataStack {

    public static let shared = CoreDataStack()

    public let container: NSPersistentContainer

    private init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "PaMovie")

        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }

        container.loadPersistentStores { _, error in
            if let error {
                fatalError("CoreData failed: \(error)")
            }
        }

        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.automaticallyMergesChangesFromParent = true
    }

    public var context: NSManagedObjectContext {
        container.viewContext
    }

    public func save() throws {
        if context.hasChanges {
            try context.save()
        }
    }
}
