//
//  AppComposition.swift
//  App
//
//  Created by Rahmat Trinanda Pramudya Amar on 23/01/26.
//

import SwiftUI
import Database
import Networking
import Movies
import UI
import CoreData

enum AppComposition {

    // MARK: - HTTP Client (Global)

    static let httpClient: HTTPClient = {
        DefaultHTTPClient(
            baseURL: "https://api.themoviedb.org/3",
            session: URLSessionAdapter()
        )
    }()

    // MARK: - Database

    static let movieStorage: MovieStorage = {
        CoreDataMovieStorage(
            context: PersistenceController.shared.container.viewContext
        )
    }()

    // MARK: - Movies Repository

    static func makeMovieRepository() -> MovieRepository {
        DefaultMovieRepository(
            api: DefaultMovieAPI(client: httpClient),
            local: MovieLocalDataSource(storage: movieStorage)
        )
    }

    // MARK: - UseCases

    static func makeGetPopularMoviesUseCase() -> GetPopularMoviesUseCase {
        DefaultGetPopularMoviesUseCase(
            repository: makeMovieRepository()
        )
    }

    // MARK: - ViewModels

    static func makePopularMoviesViewModel() -> PopularMoviesViewModel {
        PopularMoviesViewModel(
            getPopularMovies: makeGetPopularMoviesUseCase()
        )
    }

    // MARK: - Views

    static func makePopularMoviesView() -> some View {
        PopularMoviesView(
            viewModel: makePopularMoviesViewModel()
        )
    }
}
