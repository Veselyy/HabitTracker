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
            Color.red
                .tabItem {
                    VStack {
                        Image(systemName: "house")
                        Text("Home")
                    }
                }
        }
    }
}

#Preview {
    TabBarView()
}
