//
//  HomeView.swift
//  HabitTracker
//
//  Created by Martin Veselý on 25.09.2024.
//

import SwiftUI

struct HomeView: View {
    
    @State private var cards: [Card] = [
        Card(iconName: "house", title: "Home", color: .blue, progress: 30),
        Card(iconName: "chart.bar.fill", title: "History", color: .green, progress: 50),
        Card(iconName: "gear", title: "Settings", color: .red, progress: 70)
    ]
    
    // Vypočítání celkového progresu ze všech karet
    var totalProgress: Int {
        cards.map { $0.progress }.reduce(0, +) / cards.count
    }

    var body: some View {
        NavigationStack {
            VStack {
                // Skrolovatelný obsah
                ScrollView {
                    // Celkový progress kruh
                    CircularProgressView(progress: totalProgress)
                        .padding()
                        .frame(height: 150)
                        .padding(.bottom, 50)

                    // Seznam karet
                    CardsView(cards: $cards)
                }
                
                Spacer()
                
                // Vlastní TabBar na spodní části
                CustomTabBarView(tabs: [
                    TabBarItem(iconName: "house", title: "Home"),
                    TabBarItem(iconName: "chart.bar.fill", title: "History"),
                    TabBarItem(iconName: "gear", title: "Settings")
                ])
            }
            .navigationTitle("Today")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        print("Levý button stisknut")
                    }) {
                        Text("Edit")
                    }
                    .foregroundColor(.black)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        print("Pravý button stisknut")
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.black)
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView()
}

