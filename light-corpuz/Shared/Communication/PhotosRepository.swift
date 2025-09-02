//
//  PhotosRepository.swift
//  light-corpuz
//
//  Created by Michael Light Corpuz on 9/2/25.
//

import Foundation

protocol PhotosRepository {
    var canLoadMore: Bool { get }
    func reset()
    func loadNextPage() async throws -> [Photo]
}

final class DefaultPhotosRepository: PhotosRepository {
    private let service: PhotosService
    private let perPage: Int
    
    private var currentPage: Int = 0
    private(set) var canLoadMore: Bool = true
    
    // Simple in-memory cache (optional; keeps what we’ve loaded so far)
    private var cache: [Photo] = []
    
    init(service: PhotosService, perPage: Int = 20) {
        self.service = service
        self.perPage = perPage
    }
    
    func reset() {
        currentPage = 0
        canLoadMore = true
        cache.removeAll()
    }
    
    @discardableResult
    func loadNextPage() async throws -> [Photo] {
        guard canLoadMore else { return cache }
        currentPage += 1
        let new = try await service.fetchPhotos(page: currentPage, perPage: perPage)
        
        // Unsplash returns empty when no more
        if new.isEmpty || new.count < perPage {
            canLoadMore = false
        }
        cache.append(contentsOf: new)
        return cache
    }
}
