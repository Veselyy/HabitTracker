//
//  CardsView.swift
//  HabitTracker
//
//  Created by Martin Veselý on 26.09.2024.
//

import SwiftUI

struct CardsView: View {
    
    @Binding var cards: [Card] // Binding pro karty

    var body: some View {
        VStack {
            ForEach($cards) { $card in
                CardView(card: $card)
            }
        }
    }
}

struct Card: Identifiable, Hashable {
    let id = UUID()
    let iconName: String
    let title: String
    let color: Color
    var progress: Int
}

struct CardView: View {
    
    @Binding var card: Card // Binding pro kartu

    var body: some View {
        VStack {
            HStack {
                ZStack {
                    Circle()
                        .fill(card.color.opacity(0.2))
                        .frame(width: 40, height: 40)
                    Image(systemName: card.iconName)
                        .foregroundColor(card.color)
                }
                Text(card.title)
                    .font(.headline)
                Spacer()
            HStack {
                    Button(action: {
                        if card.progress < 100 {
                            card.progress += 10
                        }
                    }) {
                        Image(systemName: "plus.circle")
                            .font(.title)
                            .foregroundColor(.black)
                    }
                    
                    Button(action: {
                        if card.progress > 0 {
                            card.progress -= 10
                        }
                    }) {
                        Image(systemName: "minus.circle")
                            .font(.title)
                            .foregroundColor(.black)
                    }
                }
                Spacer()
            CircularProgressView(progress: card.progress, lineWidth: 5, font: .system(size: 12, weight: .bold))
                .frame(width: 40, height: 40)
            }
        }
        .padding()
        .background(.gray.opacity(0.1))
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding(.horizontal)
    }
}

#Preview {
    CardView(card: .constant(Card(iconName: "gear", title: "Settings", color: .red, progress: 70)))
    
    
}
