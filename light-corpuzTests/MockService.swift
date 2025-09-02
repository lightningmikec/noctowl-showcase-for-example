//
//  MockService.swift
//  light-corpuz
//
//  Created by Michael Light Corpuz on 9/3/25.
//

import Foundation
@testable import light_corpuz
import XCTest

private final class MockService: PhotosService {
    var scripted: [Result<[Photo], Error>] = []

    func fetchPhotos(page: Int, perPage: Int) async throws -> [Photo] {
        switch scripted.removeFirst() {
        case .success(let photos): return photos
        case .failure(let err): throw err
        }
    }
}

final class DefaultPhotosRepositoryTests: XCTestCase {
    func testLoadsFixturePhotos() async throws {
        let svc = MockService()
        let fixturePhotos = TestFixtures.loadPhotosFixture(named: "photos_fixture")
        svc.scripted = [.success(fixturePhotos)]
        let repo = DefaultPhotosRepository(service: svc, perPage: 20)

        let result = try await repo.loadNextPage()
        XCTAssertEqual(result.count, fixturePhotos.count)
        XCTAssertEqual(result.first?.user?.username, "tester")
    }
}
