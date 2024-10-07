//
//  AppTabBarView.swift
//  HabitTracker
//
//  Created by Martin Veselý on 05.10.2024.
//

import SwiftUI

struct AppTabBarView: View {
    
    @State private var selection: String = "home"
    
    var body: some View {
        TabView(selection: $selection){
            HomeView()
                .tabItem {
                    VStack{
                        Image(systemName: "house")
                        Text("Home")
                    }
                }
            Color.green
                .tabItem {
                    Image(systemName: "chart.bar.fill")
                    Text("History")
                }
            Color.blue
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
        }
        .padding(.top)
    }
}

#Preview {
    AppTabBarView()
}
