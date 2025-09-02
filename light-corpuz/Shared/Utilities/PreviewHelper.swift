//
//  PreviewHelper.swift
//  light-corpuz
//
//  Created by Michael Light Corpuz on 9/2/25.
//

@MainActor
struct PreviewHelper {
    static func dashboard() -> DashboardView {
        let service = UnsplashPhotosService(clientID: "GmAyo3fRrRxAFLsnuJULTgo9htKPx6Er02ZyXoMDLeI")
        let repo = DefaultPhotosRepository(service: service)
        let viewModel = DashboardViewModel(repo: repo)
        return DashboardView(viewModel: viewModel)
    }
}
