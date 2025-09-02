//
//  DashboardViewModel.swift
//  light-corpuz
//
//  Created by Michael Light Corpuz on 9/2/25.
//

import Combine
import Foundation

@MainActor
final class DashboardViewModel: ObservableObject {
    @Published private(set) var photos: [Photo] = []
    @Published private(set) var isLoading: Bool = false
    @Published var errorMessage: String?

    private let repo: PhotosRepository

    init(repo: PhotosRepository) {
        self.repo = repo
    }

    func refresh() {
        repo.reset()
        Task { await loadMore() }
    }

    func loadMore() async {
        print("[source] - loadMore()")
        guard !isLoading, repo.canLoadMore else { return }
        
        print("[source] - loadMore() fetch")
        
        isLoading = true
        errorMessage = nil
        do {
            let all = try await repo.loadNextPage()
            photos = all
            print("[source] - success \(photos.count)")
        } catch {
            errorMessage = (error as? LocalizedError)?.errorDescription ?? error.localizedDescription
            print("[source] - error \(errorMessage)")
        }
        isLoading = false
    }

    // Helper to trigger pagination from a list row
    func loadMoreIfNeeded(currentItem: Photo?) async {
        guard let currentItem, let last = photos.last else { return }
        if currentItem.id == last.id {
            await loadMore()
        }
    }
}
