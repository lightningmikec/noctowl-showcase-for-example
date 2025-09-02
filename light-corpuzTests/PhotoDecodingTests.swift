//
//  light_corpuzTests.swift
//  light-corpuzTests
//
//  Created by Michael Light Corpuz on 9/1/25.
//

import Testing
@testable import light_corpuz

@MainActor
struct PhotoDecodingTests {
    @Test("Decoding from fixture should populate Photo correctly")
    func decodeFixture() async throws {
        let photos = TestFixtures.loadPhotosFixture(named: "photos_fixture")

        #expect(!photos.isEmpty)
        #expect(photos.first?.id == "123")
        #expect(photos.first?.user?.username == "tester")
        #expect(photos.first?.urls?.regular == "https://example.com/regular.jpg")
    }
}
