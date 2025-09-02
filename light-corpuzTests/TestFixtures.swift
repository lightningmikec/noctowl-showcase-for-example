//
//  TestFixtures.swift
//  light-corpuz
//
//  Created by Michael Light Corpuz on 9/3/25.
//

import Foundation
@testable import light_corpuz

enum TestFixtures {
    static func loadPhotosFixture(named name: String) -> [Photo] {
        let bundle = Bundle(for: BundleFinder.self)
        guard let url = bundle.url(forResource: name, withExtension: "json") else {
            fatalError("Missing file: \(name).json")
        }
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            decoder.dateDecodingStrategy = .iso8601
            return try decoder.decode([Photo].self, from: data)
        } catch {
            fatalError("Decoding failed: \(error)")
        }
    }
}

// Marker class so we can locate the right bundle
private class BundleFinder {}
