//
//  SquareRemoteImage.swift
//  light-corpuz
//
//  Created by Michael Light Corpuz on 9/2/25.
//

import SwiftUI

struct SquareRemoteImage: View {
    let url: URL?

    var body: some View {
        GeometryReader { geo in
            let side = geo.size.width   // <- actual width available

            AsyncImage(url: url) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: side, height: side)

                case .success(let image):
                    image.resizable()
                         .scaledToFill()                // Instagram look (crops)
                         .frame(width: side, height: side)
                         .clipped()

                case .failure:
                    Color.gray.opacity(0.2)
                        .frame(width: side, height: side)

                @unknown default:
                    EmptyView()
                }
            }
        }
        // Give GeometryReader a height (otherwise it is 0)
        .aspectRatio(1, contentMode: .fit)              // square
    }
}
