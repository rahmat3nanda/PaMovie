//
//  PaMovieApp.swift
//  PaMovie
//
//  Created by Rahmat Trinanda Pramudya Amar on 22/01/26.
//

import SwiftUI
import CoreData

@main
struct PaMovieApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
