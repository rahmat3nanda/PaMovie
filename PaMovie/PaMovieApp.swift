//
//  PaMovieApp.swift
//  PaMovie
//
//  Created by Rahmat Trinanda Pramudya Amar on 22/01/26.
//

import SwiftUI

@main
struct PaMovieApp: App {
    var body: some Scene {
        WindowGroup {
            AppComposition.makePopularMoviesView()
        }
    }
}
