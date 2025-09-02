//
//  String+Date.swift
//  light-corpuz
//
//  Created by Michael Light Corpuz on 9/2/25.
//

import Foundation

extension String {
    /// Converts an ISO8601 string (e.g. "2025-08-31T14:16:46Z")
    /// into a human-readable format (e.g. "August 13, 1998")
    func toReadableDate() -> String? {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime]

        guard let date = isoFormatter.date(from: self) else { return nil }

        let formatter = DateFormatter()
        formatter.dateStyle = .long        // "August 13, 1998"
        formatter.timeStyle = .none
        formatter.locale = Locale(identifier: "en_US_POSIX")

        return formatter.string(from: date)
    }
}
