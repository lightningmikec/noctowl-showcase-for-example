//
//  Untitled.swift
//  light-corpuz
//
//  Created by Michael Light Corpuz on 9/2/25.
//

import SwiftUI

struct PhotoFullscreenView: View {
    let photo: Photo
    
    @Environment(\.dismiss) private var dismiss

    @State private var scale: CGFloat = 1
    @State private var lastScale: CGFloat = 1
    @State private var offset: CGSize = .zero

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            let url = URL(string: photo.urls?.full ?? photo.urls?.regular ?? "")

            AsyncImage(url: url) { phase in
                switch phase {
                case .empty:
                    ProgressView().tint(.white)
                case .failure:
                    Image(systemName: "photo").foregroundStyle(.white)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .scaleEffect(scale)
                        .offset(offset)
                        .gesture(
                            MagnificationGesture()
                                .onChanged { value in
                                    let newScale = lastScale * value
                                    scale = min(max(newScale, 1), 4)
                                }
                                .onEnded { _ in
                                    lastScale = scale
                                }
                        )
                        .highPriorityGesture(
                            TapGesture(count: 2).onEnded {
                                withAnimation(.easeInOut) {
                                    if scale == 1 {
                                        scale = 2; lastScale = 2
                                    } else {
                                        scale = 1; lastScale = 1
                                        offset = .zero
                                    }
                                }
                            }
                        )
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    if scale == 1 { offset = value.translation }
                                }
                                .onEnded { value in
                                    if scale == 1, abs(value.translation.height) > 120 {
                                        dismiss()
                                    } else if scale == 1 {
                                        withAnimation(.spring) { offset = .zero }
                                    }
                                }
                        )
                        .transition(.opacity)
                @unknown default:
                    EmptyView()
                }
            }
            .ignoresSafeArea()

            // Close button
            VStack {
                HStack {
                    Spacer()
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundStyle(.white)
                            .shadow(radius: 2)
                    }
                    .padding()
                    .accessibilityLabel("Close")
                }
                Spacer()
            }
        }
        .statusBarHidden(true) // immersive
    }
}
