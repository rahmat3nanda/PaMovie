//
//  ErrorView.swift
//  UI
//
//  Created by Rahmat Trinanda Pramudya Amar on 23/01/26.
//

import SwiftUI

public struct ErrorView: View {

    private let message: String
    private let retry: () -> Void

    public init(
        message: String,
        retry: @escaping () -> Void
    ) {
        self.message = message
        self.retry = retry
    }

    public var body: some View {
        VStack(spacing: 12) {
            Text("Error")
                .font(.headline)

            Text(message)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)

            Button("Retry", action: retry)
        }
        .padding()
    }
}
