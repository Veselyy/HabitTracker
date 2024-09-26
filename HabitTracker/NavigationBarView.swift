//
//  NavigationBarView.swift
//  HabitTracker
//
//  Created by Martin Veselý on 25.09.2024.
//

import SwiftUI

struct NavigationBarView: View {
    
    let tabs: [TabBarItem] = [
        TabBarItem(iconName: "house", title: "Home"),
        TabBarItem(iconName: "chart.bar.fill", title: "History"),
        TabBarItem(iconName: "gear", title: "Settings")
    ]
        
    var body: some View {
        VStack{
            Spacer()
            CustomTabBarView(tabs: tabs)
        }
    }
}

#Preview {
    NavigationBarView()
}
