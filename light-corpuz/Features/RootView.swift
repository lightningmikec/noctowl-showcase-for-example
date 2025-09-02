//
//  RootView.swift
//  light-corpuz
//
//  Created by Michael Light Corpuz on 9/2/25.
//

import SwiftUI

enum AppTab: Hashable {
    case exam, credits
}

struct RootView: View {
    @State private var tab: AppTab = .exam
    let dashboardVM: DashboardViewModel

    var body: some View {
        TabView(selection: $tab) {
            // Exam
            NavigationStack {
                DashboardView(viewModel: dashboardVM)
            }
            .tabItem {
                Label("Exam", systemImage: "house.fill")
            }
            .tag(AppTab.exam)

            // Profile
            NavigationStack {
                EmptyView()
            }
            .tabItem {
                Label("Profile", systemImage: "person.fill")
            }
            .tag(AppTab.credits)
        }
    }
}
