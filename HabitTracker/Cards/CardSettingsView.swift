//
//  CardSettingsView.swift
//  HabitTracker
//
//  Created by Martin Veselý on 02.10.2024.
//

import SwiftUI

struct CardSettingsView: View {
    @Binding var card: Card
    
    init(card: Binding<Card>) {
        self._card = card
    }
    
    var body: some View {
        VStack() {
            Text(card.title)
                .font(.largeTitle)
                .bold()
            Text("Daily goal: \(card.goal)")
                .font(.subheadline)
        }
    }
}
#Preview {
    CardSettingsView(card: .constant(Card(iconName: "star", title: "Test Card", color: .blue, goal: "100%", progress: 50)))
}
