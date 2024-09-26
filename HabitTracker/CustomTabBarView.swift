//  CustomTabBarView.swift
//  HabitTracker
//
//  Created by Martin Veselý on 25.09.2024.
//

import SwiftUI

struct CustomTabBarView: View {
    
    let tabs: [TabBarItem]
    @State var selection: TabBarItem = TabBarItem(iconName: "house", title: "Home")
    
    var body: some View {
        HStack {
            Spacer() // Mezera od levého okraje obrazovky

            ForEach(tabs) { tab in
                tabView(tab: tab)
                    .onTapGesture {
                        switchToTab(tab: tab)
                    }
                
                if tab != tabs.last {
                    Spacer() // Mezera mezi položkami
                }
            }

            Spacer() // Mezera od pravého okraje obrazovky
        }
        .padding(.top)
        .background(Color.gray.opacity(0.3))
    }
}

struct TabBarItem: Identifiable, Hashable {
    let id = UUID()
    let iconName: String
    let title: String
}

extension CustomTabBarView {
    private func tabView(tab: TabBarItem) -> some View {
        VStack {
            Image(systemName: tab.iconName)
            Text(tab.title)
        }
        .foregroundColor(selection == tab ? Color.black: Color.gray )
    }
    
    private func switchToTab(tab: TabBarItem){
            selection = tab
    }
}

struct CustomTabBarView_Previews: PreviewProvider {
    static var previews: some View {
        let tabs: [TabBarItem] = [
            TabBarItem(iconName: "house", title: "Home"),
            TabBarItem(iconName: "chart.bar.fill", title: "History"),
            TabBarItem(iconName: "gear", title: "Settings")
        ]
        
        // Vytvoření náhledu
        VStack{
            Spacer()
            CustomTabBarView(tabs: tabs)
        }
    }
}
