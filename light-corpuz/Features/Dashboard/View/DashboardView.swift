//
//  DashboardView.swift
//  light-corpuz
//
//  Created by Michael Light Corpuz on 9/2/25.
//

import SwiftUI

struct DashboardView: View {
    
    @ObservedObject var viewModel: DashboardViewModel
    @State private var selectedPhoto: Photo?
    
    var body: some View {
        ScrollView {
            listView()
        }
        .refreshable {
            viewModel.refresh()
        }
        .task {
            await viewModel.loadMore()
        }
        .navigationTitle("For You")
        .navigationBarTitleDisplayMode(.large)
        .fullScreenCover(item: $selectedPhoto) { photo in
            PhotoFullscreenView(photo: photo)
        }
    }
    
    private func listView() -> some View {
        LazyVStack(spacing: 24) {
            ForEach(Array(viewModel.photos.enumerated()), id: \.element.id) { index, photo in
                cardView(photo: photo)
                    .onAppear {
                        Task {
                            await viewModel.loadMoreIfNeeded(currentItem: photo)
                        }
                    }
            }
        }
    }
    
    private func cardView(photo: Photo) -> some View {
        VStack(spacing: 8) {
            ProfileHeaderView(post: photo)
            PictureView(post: photo) {
                selectedPhoto = photo
            }
            PostStatisticsView(post: photo)
            PostCaptionView(post: photo)
        }
    }
}

#Preview {
    PreviewHelper.dashboard()
}
