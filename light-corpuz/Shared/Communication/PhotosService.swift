//
//  PhotosService.swift
//  light-corpuz
//
//  Created by Michael Light Corpuz on 9/2/25.
//

import Foundation

protocol PhotosService {
    func fetchPhotos(page: Int, perPage: Int) async throws -> [Photo]
}

struct UnsplashPhotosService: PhotosService {
    let clientID: String
    var baseURL: String = "https://api.unsplash.com/photos"
    
    func fetchPhotos(page: Int, perPage: Int) async throws -> [Photo] {
        guard var comps = URLComponents(string: baseURL) else {
            throw NetworkError.badURL
        }
        comps.queryItems = [
            .init(name: "client_id", value: clientID),
            .init(name: "page", value: String(page)),
            .init(name: "per_page", value: String(perPage))
        ]
        
        guard let url = comps.url else { throw NetworkError.badURL }
        
        var request = URLRequest(url: url)
        // Optional but recommended by Unsplash:
        request.setValue("v1", forHTTPHeaderField: "Accept-Version")
        // If you prefer header auth instead of query param:
        // request.setValue("Client-ID \(clientID)", forHTTPHeaderField: "Authorization")
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            let status = (response as? HTTPURLResponse)?.statusCode ?? 0
            guard (200..<300).contains(status) else { throw NetworkError.badStatus(status) }
            do {
                return try JSONDecoder.unsplash.decode([Photo].self, from: data)
            } catch {
                throw NetworkError.decoding(error)
            }
        } catch {
            throw NetworkError.other(error)
        }
    }
}
