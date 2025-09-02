//
//  MockPhotosRepository.swift
//  light-corpuz
//
//  Created by Michael Light Corpuz on 9/3/25.
//

import Testing
import XCTest
@testable import light_corpuz

final class MockPhotosRepository: PhotosRepository {
    var canLoadMore: Bool = true
    var resetCalled = false
    var loadNextPageCalled = 0
    var resultQueue: [Result<[Photo], Error>] = []

    func reset() { resetCalled = true }

    func loadNextPage() async throws -> [Photo] {
        loadNextPageCalled += 1
        try await Task.sleep(nanoseconds: 5_000_000) // simulate async chuchu
        guard !resultQueue.isEmpty else { return [] }
        switch resultQueue.removeFirst() {
        case .success(let photos): return photos
        case .failure(let err): throw err
        }
    }
}
