//
//  DashboardViewModelTests.swift.swift
//  light-corpuz
//
//  Created by Michael Light Corpuz on 9/3/25.
//

import Testing
import Foundation
@testable import light_corpuz

@MainActor
struct DashboardViewModelTests {
    @Test("loadMore loads photos successfully")
    func loadMore_successLoadsPhotos() async {
        let repo = MockPhotosRepository()
        let fixture = TestFixtures.loadPhotosFixture(named: "photos_fixture")
        repo.resultQueue = [.success(fixture)]

        let vm = DashboardViewModel(repo: repo)
        await vm.loadMore()

        #expect(repo.loadNextPageCalled == 1)
        #expect(vm.photos.count == fixture.count)
        #expect(vm.errorMessage == nil)
    }

    @Test("loadMore handles error properly")
    func loadMore_handlesError() async {
        let repo = MockPhotosRepository()
        repo.resultQueue = [.failure(NSError(domain: "Test", code: 1))]
        let vm = DashboardViewModel(repo: repo)

        await vm.loadMore()

        #expect(repo.loadNextPageCalled == 1)
        #expect(vm.photos.isEmpty)
        #expect(vm.errorMessage != nil)
    }

    @Test("refresh resets repo and reloads photos")
    func refresh_resetsAndReloads() async throws {
        let repo = MockPhotosRepository()
        repo.resultQueue = [
            .success([Photo(id: "1", slug: nil, alternativeSlugs: nil,
                            createdAt: nil, updatedAt: nil, promotedAt: nil,
                            width: nil, height: nil, color: nil, blurHash: nil,
                            description: nil, altDescription: nil,
                            urls: nil, links: nil, likes: nil,
                            likedByUser: nil, sponsorship: nil,
                            topicSubmissions: nil, assetType: nil, user: nil)])
        ]
        let vm = DashboardViewModel(repo: repo)

        vm.refresh()
        try await Task.sleep(nanoseconds: 50_000_000) // give the Task a moment

        #expect(repo.resetCalled)
        #expect(repo.loadNextPageCalled == 1)
    }

    @Test("loadMoreIfNeeded triggers only on last item")
    func loadMoreIfNeeded_onlyOnLastItem() async {
        let repo = MockPhotosRepository()
        let fixture = [
            Photo(id: "a", slug: nil, alternativeSlugs: nil,
                  createdAt: nil, updatedAt: nil, promotedAt: nil,
                  width: nil, height: nil, color: nil, blurHash: nil,
                  description: nil, altDescription: nil,
                  urls: nil, links: nil, likes: nil,
                  likedByUser: nil, sponsorship: nil,
                  topicSubmissions: nil, assetType: nil, user: nil),
            Photo(id: "b", slug: nil, alternativeSlugs: nil,
                  createdAt: nil, updatedAt: nil, promotedAt: nil,
                  width: nil, height: nil, color: nil, blurHash: nil,
                  description: nil, altDescription: nil,
                  urls: nil, links: nil, likes: nil,
                  likedByUser: nil, sponsorship: nil,
                  topicSubmissions: nil, assetType: nil, user: nil)
        ]
        repo.resultQueue = [.success(fixture)]

        let vm = DashboardViewModel(repo: repo)
        await vm.loadMore()

        // Not last item → no new call
        await vm.loadMoreIfNeeded(currentItem: fixture.first)
        #expect(repo.loadNextPageCalled == 1)

        // Last item → should trigger new call
        repo.resultQueue = [.success(fixture + [fixture.first!])]
        await vm.loadMoreIfNeeded(currentItem: fixture.last)
        #expect(repo.loadNextPageCalled == 2)
    }
}
