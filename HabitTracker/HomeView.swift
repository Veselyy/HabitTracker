//
//  HomeView.swift
//  HabitTracker
//
//  Created by Martin Veselý on 25.09.2024.
//

import SwiftUI

struct HomeView: View {
    
    @State public var cards: [Card] = [
        Card(iconName: "powersleep", title: "Sleep", color: .blue,goal: "8 hr", progress: 0),
        Card(iconName: "drop.fill", title: "Drink Water", color: .green, goal: "5 l", progress: 0),
        Card(iconName: "checklist", title: "Review My Day", color: .red, goal: "1x", progress: 0),
        Card(iconName: "figure.walk", title: "Take a walk", color: .purple,goal: "5 000 steps", progress: 0),
        Card(iconName: "figure", title: "Learn a new think", color: .brown, goal: "5 l", progress: 0),
        Card(iconName: "figure.run", title: "Movement", color: .blue,goal: "1 h", progress: 0),
        Card(iconName: "fork.knife", title: "Record a food", color: .pink, goal: "1x", progress: 0),
        Card(iconName: "checklist", title: "Review My Day", color: .yellow, goal: "1x", progress: 0),
        Card(iconName: "iphone.gen1.slash", title: "Reduce social media", color: .black,goal: "15 minutes", progress: 0),
        Card(iconName: "checklist", title: "Plan my day", color: .gray, goal: "1x", progress: 0)
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
                ToolbarItem(placement: .primaryAction) {
                    NavigationLink(destination: HomeEditView(cards: $cards)) {
                        Text("Edit")
                            .foregroundColor(.primary)
                    }
                }
                ToolbarItem(placement: .primaryAction) {
                    Button(action: {
                        print("Pravý button stisknut")
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.primary)
                    }
                }
            }
            .onAppear {
                resetAllCards()
            }
        }
    }
    // Funkce pro resetování `isChecked` u všech karet
    private func resetAllCards() {
        for index in cards.indices {
            cards[index].isChecked = false
        }
    }
}


#Preview {
    HomeView()
}
