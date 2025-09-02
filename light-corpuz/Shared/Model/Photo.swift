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
    let createdAt, updatedAt: String?
    let promotedAt: String?
    let width, height: Int?
    let color, blurHash: String?
    let description: String?
    let altDescription: String?
    let urls: Urls?
    let links: PhotoLinks?
    let likes: Int?
    let likedByUser: Bool?
    let sponsorship: Sponsorship?
    let topicSubmissions: TopicSubmissions?
    let assetType: AssetType?
    let user: User?

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
        case sponsorship
        case topicSubmissions = "topic_submissions"
        case assetType = "asset_type"
        case user
    }
}

// MARK: - AlternativeSlugs
struct AlternativeSlugs: Codable {
    let en, es, ja, fr: String?
    let it, ko, de, pt: String?
    let id: String?
}

enum AssetType: String, Codable {
    case photo = "photo"
}

// MARK: - PhotoLinks
struct PhotoLinks: Codable {
    let linksSelf, html, download, downloadLocation: String?

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case html, download
        case downloadLocation = "download_location"
    }
}

// MARK: - Sponsorship
struct Sponsorship: Codable {
    let impressionUrls: [String]?
    let tagline: String?
    let taglineURL: String?
    let sponsor: User?

    enum CodingKeys: String, CodingKey {
        case impressionUrls = "impression_urls"
        case tagline
        case taglineURL = "tagline_url"
        case sponsor
    }
}

// MARK: - User
struct User: Codable {
    let id: String?
    let updatedAt: String?
    let username, name, firstName: String?
    let lastName, twitterUsername: String?
    let portfolioURL: String?
    let bio, location: String?
    let links: UserLinks?
    let profileImage: ProfileImage?
    let instagramUsername: String?
    let totalCollections, totalLikes, totalPhotos, totalPromotedPhotos: Int?
    let totalIllustrations, totalPromotedIllustrations: Int?
    let acceptedTos, forHire: Bool?
    let social: Social?

    enum CodingKeys: String, CodingKey {
        case id
        case updatedAt = "updated_at"
        case username, name
        case firstName = "first_name"
        case lastName = "last_name"
        case twitterUsername = "twitter_username"
        case portfolioURL = "portfolio_url"
        case bio, location, links
        case profileImage = "profile_image"
        case instagramUsername = "instagram_username"
        case totalCollections = "total_collections"
        case totalLikes = "total_likes"
        case totalPhotos = "total_photos"
        case totalPromotedPhotos = "total_promoted_photos"
        case totalIllustrations = "total_illustrations"
        case totalPromotedIllustrations = "total_promoted_illustrations"
        case acceptedTos = "accepted_tos"
        case forHire = "for_hire"
        case social
    }

    init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)

        print("🔎 has profile_image key:", c.contains(.profileImage))

        // decode normally
        id = try c.decodeIfPresent(String.self, forKey: .id)
        updatedAt = try c.decodeIfPresent(String.self, forKey: .updatedAt)
        username = try c.decodeIfPresent(String.self, forKey: .username)
        name = try c.decodeIfPresent(String.self, forKey: .name)
        firstName = try c.decodeIfPresent(String.self, forKey: .firstName)
        lastName = try c.decodeIfPresent(String.self, forKey: .lastName)
        twitterUsername = try c.decodeIfPresent(String.self, forKey: .twitterUsername)
        portfolioURL = try c.decodeIfPresent(String.self, forKey: .portfolioURL)
        bio = try c.decodeIfPresent(String.self, forKey: .bio)
        location = try c.decodeIfPresent(String.self, forKey: .location)
        links = try c.decodeIfPresent(UserLinks.self, forKey: .links)

        // decode the profile image explicitly so we can log failures
        do {
            profileImage = try c.decodeIfPresent(ProfileImage.self, forKey: .profileImage)
            print("✅ decoded profileImage:", profileImage?.medium ?? "nil")
        } catch {
            print("❌ failed decoding profileImage:", error)
            profileImage = nil
        }

        instagramUsername = try c.decodeIfPresent(String.self, forKey: .instagramUsername)
        totalCollections = try c.decodeIfPresent(Int.self, forKey: .totalCollections)
        totalLikes = try c.decodeIfPresent(Int.self, forKey: .totalLikes)
        totalPhotos = try c.decodeIfPresent(Int.self, forKey: .totalPhotos)
        totalPromotedPhotos = try c.decodeIfPresent(Int.self, forKey: .totalPromotedPhotos)
        totalIllustrations = try c.decodeIfPresent(Int.self, forKey: .totalIllustrations)
        totalPromotedIllustrations = try c.decodeIfPresent(Int.self, forKey: .totalPromotedIllustrations)
        acceptedTos = try c.decodeIfPresent(Bool.self, forKey: .acceptedTos)
        forHire = try c.decodeIfPresent(Bool.self, forKey: .forHire)
        social = try c.decodeIfPresent(Social.self, forKey: .social)
    }
}

// MARK: - UserLinks
struct UserLinks: Codable {
    let linksSelf, html, photos, likes: String?
    let portfolio: String?

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case html, photos, likes, portfolio
    }
}

// MARK: - ProfileImage
struct ProfileImage: Codable {
    let small, medium, large: String?
}

// MARK: - Social
struct Social: Codable {
    let instagramUsername: String?
    let portfolioURL: String?
    let twitterUsername: String?

    enum CodingKeys: String, CodingKey {
        case instagramUsername = "instagram_username"
        case portfolioURL = "portfolio_url"
        case twitterUsername = "twitter_username"
    }
}

// MARK: - TopicSubmissions
struct TopicSubmissions: Codable {
    let streetPhotography, experimental, people, wallpapers: Experimental?
    let film: Experimental?

    enum CodingKeys: String, CodingKey {
        case streetPhotography = "street-photography"
        case experimental, people, wallpapers, film
    }
}

// MARK: - Experimental
struct Experimental: Codable {
    let status: Status?
    let approvedOn: String?

    enum CodingKeys: String, CodingKey {
        case status
        case approvedOn = "approved_on"
    }
}

enum Status: String, Codable {
    case approved = "approved"
    case rejected = "rejected"
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

extension Photo {
    var author: String {
        if let username = user?.username {
            "@\(username)"
        } else if let name = user?.name {
            name
        } else {
            "Anonymous"
        }
    }
}
