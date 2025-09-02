//
//  DashboardViewModelTests.swift.swift
//  light-corpuz
//
//  Created by Michael Light Corpuz on 9/3/25.
//

import XCTest
@testable import light_corpuz

@MainActor
final class DashboardViewModelTests: XCTestCase {

    func testLoadMore_successLoadsPhotos() async {
        let repo = MockPhotosRepository()
        let fixture = TestFixtures.loadPhotosFixture(named: "photos_fixture")
        repo.resultQueue = [.success(fixture)]

        let vm = DashboardViewModel(repo: repo)
        await vm.loadMore()

        XCTAssertEqual(repo.loadNextPageCalled, 1)
        XCTAssertEqual(vm.photos.count, fixture.count)
        XCTAssertNil(vm.errorMessage)
    }

    func testLoadMore_handlesError() async {
        let repo = MockPhotosRepository()
        repo.resultQueue = [.failure(NSError(domain: "Test", code: 1))]
        let vm = DashboardViewModel(repo: repo)

        await vm.loadMore()

        XCTAssertEqual(repo.loadNextPageCalled, 1)
        XCTAssertTrue(vm.photos.isEmpty)
        XCTAssertNotNil(vm.errorMessage)
    }

    func testRefresh_resetsAndReloads() async {
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
        try? await Task.sleep(nanoseconds: 50_000_000)

        XCTAssertTrue(repo.resetCalled)
        XCTAssertEqual(repo.loadNextPageCalled, 1)
    }

    func testLoadMoreIfNeeded_onlyOnLastItem() async {
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

        // Trigger with first photo: should NOT call again
        await vm.loadMoreIfNeeded(currentItem: fixture.first)
        XCTAssertEqual(repo.loadNextPageCalled, 1)

        // Trigger with last photo: should call again
        repo.resultQueue = [.success(fixture + [fixture.first!])]
        await vm.loadMoreIfNeeded(currentItem: fixture.last)
        XCTAssertEqual(repo.loadNextPageCalled, 2)
    }
}
