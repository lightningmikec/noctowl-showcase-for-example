//
//  MockService.swift
//  light-corpuz
//
//  Created by Michael Light Corpuz on 9/3/25.
//

import Foundation
import Testing
@testable import light_corpuz

private final class MockService: PhotosService {
    var scripted: [Result<[Photo], Error>] = []

    func fetchPhotos(page: Int, perPage: Int) async throws -> [Photo] {
        switch scripted.removeFirst() {
        case .success(let photos): return photos
        case .failure(let err): throw err
        }
    }
}

@MainActor
struct DefaultPhotosRepositoryTests {
    @Test("Repository loads photos from fixture correctly")
    func loadsFixturePhotos() async throws {
        let svc = MockService()
        let fixturePhotos = TestFixtures.loadPhotosFixture(named: "photos_fixture")
        svc.scripted = [.success(fixturePhotos)]
        let repo = DefaultPhotosRepository(service: svc, perPage: 20)

        let result = try await repo.loadNextPage()

        #expect(result.count == fixturePhotos.count)
        #expect(result.first?.user?.username == "tester")
    }
}
