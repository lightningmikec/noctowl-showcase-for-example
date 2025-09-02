//
//  DashboardView.swift
//  light-corpuz
//
//  Created by Michael Light Corpuz on 9/2/25.
//

import Kingfisher
import SwiftUI

struct DashboardView: View {
    @ObservedObject var viewModel: DashboardViewModel
    
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
        .navigationTitle("For You") // <- title in the nav bar
        .navigationBarTitleDisplayMode(.large) // <- inline vs large
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
            PictureView(post: photo)
            PostStatisticsView(post: photo)
            PostCaptionView(post: photo)
        }
    }
}

#Preview {
    PreviewHelper.dashboard()
}

struct ExamConstants {
    static let padding: CGFloat = 12
}
