//
//  light_corpuzTests.swift
//  light-corpuzTests
//
//  Created by Michael Light Corpuz on 9/1/25.
//

import Testing
import XCTest
@testable import light_corpuz

@MainActor
final class PhotoDecodingTests: XCTestCase {
    func testDecodingPhotosFromFixture() {
        let photos = TestFixtures.loadPhotosFixture(named: "photos_fixture")
        XCTAssertFalse(photos.isEmpty)
        XCTAssertEqual(photos.first?.id, "123")
        XCTAssertEqual(photos.first?.user?.username, "tester")
        XCTAssertEqual(photos.first?.urls?.regular, "https://example.com/regular.jpg")
    }
}
