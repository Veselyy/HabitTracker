//
//  TabBarView.swift
//  HabitTracker
//
//  Created by Martin Veselý on 06.10.2024.
//

import SwiftUI

struct TabBarView: View {
    
    @State private var selection = 0
    
    var body: some View {
        TabView(selection: $selection) {
            HomeView()
                .tabItem {
                    VStack {
                        Image("Symbol") // TODO custom symbol in FIGMA
                            .foregroundStyle(Color.black)
                        Text("Home")
                    }
                }
            HistoryView()
                .tabItem {
                    VStack {
                        Image(systemName: "chart.bar.fill")
                        Text("History")
                    }
                }
            SettingsView()
                .tabItem {
                    VStack {
                        Image(systemName: "gear")
                        Text("Settings")
                    }
                }
        }.tint(Color.primary)
    }
}

#Preview {
    TabBarView()
}
