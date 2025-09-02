//
//  PreviewHelper.swift
//  light-corpuz
//
//  Created by Michael Light Corpuz on 9/2/25.
//

import SwiftUI

@MainActor
struct PreviewHelper {
    static func dashboard() -> some View {
        let service = UnsplashPhotosService(clientID: "GmAyo3fRrRxAFLsnuJULTgo9htKPx6Er02ZyXoMDLeI")
        let repo = DefaultPhotosRepository(service: service)
        let viewModel = DashboardViewModel(repo: repo)
        return NavigationStack {
            DashboardView(viewModel: viewModel)
        }
    }
}

#Preview {
    PreviewHelper.dashboard()
}
