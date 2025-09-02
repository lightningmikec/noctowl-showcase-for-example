//
//  DashboardView.swift
//  light-corpuz
//
//  Created by Michael Light Corpuz on 9/2/25.
//

import SwiftUI

struct DashboardView: View {
    
    @ObservedObject var viewModel: DashboardViewModel
    
    var body: some View {
        ScrollView {
            ForEach(viewModel.photos) { photo in
                cardView(photo: photo)
            }
        }
        .refreshable {
            // todo refrsh action
        }
        .task {
            await viewModel.loadMore()
        }
        
        // todo fetch data
    }
    
    private func cardView(photo: Photo) -> some View {
        HStack {
            Color(.red)
                .frame(width: 100, height: 100)
            VStack {
                Text(photo.id ?? "")
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(photo.slug ?? "")
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}

#Preview {
    PreviewHelper.dashboard()
}
