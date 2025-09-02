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
