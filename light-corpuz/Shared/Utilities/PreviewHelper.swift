//
//  PreviewHelper.swift
//  light-corpuz
//
//  Created by Michael Light Corpuz on 9/2/25.
//

import SwiftUI

@MainActor
struct PreviewHelper {
    private static func dashboardViewModel() -> DashboardViewModel{
        let service = UnsplashPhotosService(clientID: "GmAyo3fRrRxAFLsnuJULTgo9htKPx6Er02ZyXoMDLeI")
        let repo = DefaultPhotosRepository(service: service)
        return DashboardViewModel(repo: repo)
    }
    
    static func dashboard() -> some View {
        let viewModel = dashboardViewModel()
        return NavigationStack {
            DashboardView(viewModel: viewModel)
        }
    }
    
    static func app() -> some View {
        let dashboardVM = dashboardViewModel()
        return RootView(dashboardVM: dashboardVM)
    }
}

#Preview {
    PreviewHelper.app()
}
