//
//  RemoteImageView.swift
//  UI
//
//  Created by Rahmat Trinanda Pramudya Amar on 23/01/26.
//

import Foundation
import SwiftUI
internal import Kingfisher

public struct RemoteImageView: View {

    private let url: URL?
    private let width: CGFloat
    private let height: CGFloat
    private let cornerRadius: CGFloat

    public init(
        url: URL?,
        width: CGFloat,
        height: CGFloat,
        cornerRadius: CGFloat = 8
    ) {
        self.url = url
        self.width = width
        self.height = height
        self.cornerRadius = cornerRadius
    }

    public var body: some View {
        KFImage(url)
            .placeholder {
                Color.gray.opacity(0.3)
            }
            .resizable()
            .cancelOnDisappear(true)
            .scaledToFill()
            .frame(width: width, height: height)
            .clipShape(
                RoundedRectangle(cornerRadius: cornerRadius)
            )
    }
}
