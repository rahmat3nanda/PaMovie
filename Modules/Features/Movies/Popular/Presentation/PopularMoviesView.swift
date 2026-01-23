//
//  PopularMoviesView.swift
//  Movies
//
//  Created by Rahmat Trinanda Pramudya Amar on 23/01/26.
//

import Foundation
import SwiftUI
import UI

public struct PopularMoviesView: View {

    @StateObject private var viewModel: PopularMoviesViewModel

    public init(viewModel: PopularMoviesViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    public var body: some View {
        NavigationView {
            content
                .navigationBarTitle("Popular Movies", displayMode: .large)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear {
            load()
        }
    }

    @ViewBuilder
    private var content: some View {
        if viewModel.isLoading {
            ProgressView()
        } else {
            List(viewModel.movies) { movie in
                PopularMoviesRowView(movie: movie)
            }
            .listStyle(PlainListStyle())
        }
    }

    private func load() {
        guard viewModel.movies.isEmpty else { return }

        Task {
            await viewModel.load()
        }
    }
}
