//
//  DashboardViewModel.swift
//  light-corpuz
//
//  Created by Michael Light Corpuz on 9/2/25.
//

import Foundation

struct Photo: Identifiable {
    var id: String {
        name + image
    }
    
    var name: String
    var image: String
}

class DashboardViewModel: ObservableObject {
    
    @Published var photos: [Photo] = [.init(name: "Sample", image: "Ihgu"), .init(name: "Saaaa", image: "Ssaaadddge")]
    
    private func fetchPhotos() {
        // todo fetch data
    }
}
