//
//  NetworkHelpers.swift
//  light-corpuz
//
//  Created by Michael Light Corpuz on 9/2/25.
//

import Foundation

// MARK: - Networking Helpers
enum NetworkError: Error, LocalizedError {
    case badURL
    case badStatus(Int)
    case decoding(Error)
    case other(Error)
    
    var errorDescription: String? {
        switch self {
        case .badURL: return "Invalid URL."
        case .badStatus(let code): return "Server responded with status \(code)."
        case .decoding(let err): return "Failed to decode response: \(err.localizedDescription)"
        case .other(let err): return err.localizedDescription
        }
    }
}

extension JSONDecoder {
    static let unsplash: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        // Unsplash dates can include fractional seconds; support both.
        decoder.dateDecodingStrategy = .custom { decoder in
            let container = try decoder.singleValueContainer()
            let raw = try container.decode(String.self)
            
            // Try with fractional seconds first
            let isoFrac = ISO8601DateFormatter()
            isoFrac.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
            
            if let d = isoFrac.date(from: raw) { return d }
            
            let iso = ISO8601DateFormatter()
            iso.formatOptions = [.withInternetDateTime]
            if let d = iso.date(from: raw) { return d }
            
            // If all else fails
            throw DecodingError.dataCorruptedError(in: container,
                                                   debugDescription: "Invalid ISO8601 date: \(raw)")
        }
        return decoder
    }()
}
