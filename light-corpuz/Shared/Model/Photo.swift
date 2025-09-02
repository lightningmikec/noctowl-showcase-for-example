//
//  Photo.swift
//  light-corpuz
//
//  Created by Michael Light Corpuz on 9/2/25.
//

import Foundation

// MARK: - PhotoElement
struct Photo: Codable, Identifiable {
    let id, slug: String?
    let alternativeSlugs: AlternativeSlugs?
    let createdAt, updatedAt: Date?
    let promotedAt: Date?
    let width, height: Int?
    let color, blurHash: String?
    let description: String?
    let altDescription: String?
    let urls: Urls?
    let links: Links?
    let likes: Int?
    let likedByUser: Bool?

    enum CodingKeys: String, CodingKey {
        case id, slug
        case alternativeSlugs = "alternative_slugs"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case promotedAt = "promoted_at"
        case width, height, color
        case blurHash = "blur_hash"
        case description
        case altDescription = "alt_description"
        case urls, links, likes
        case likedByUser = "liked_by_user"
    }
}

// MARK: - AlternativeSlugs
struct AlternativeSlugs: Codable {
    let en, es, ja, fr: String?
    let it, ko, de, pt: String?
    let id: String?
}

// MARK: - Links
struct Links: Codable {
    let linksSelf, html, download, downloadLocation: String?

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case html, download
        case downloadLocation = "download_location"
    }
}

// MARK: - Urls
struct Urls: Codable {
    let raw, full, regular, small: String?
    let thumb, smallS3: String?

    enum CodingKeys: String, CodingKey {
        case raw, full, regular, small, thumb
        case smallS3 = "small_s3"
    }
}
