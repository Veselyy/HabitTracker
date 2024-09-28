//
//  CardsView.swift
//  HabitTracker
//
//  Created by Martin Veselý on 26.09.2024.
//

import SwiftUI

// Model for Card
struct Card: Identifiable, Hashable {
    let id = UUID()
    let iconName: String
    let title: String
    let color: Color
    let goal: String
    var progress: Int
}

// Main View for displaying multiple cards
struct CardsView: View {
    @Binding var cards: [Card] // Binding for cards
    @State private var selectedCard: Card? // Stores selected card for modal window

    var body: some View {
        VStack {
            ForEach($cards) { $card in
                CardView(card: $card,selectedCard: $selectedCard)
            }
        }
        .sheet(item: $selectedCard) { card in
            TimerSettingsView(card: Binding<Card>(
                get: { card },
                set: { newCard in
                    // Update the card in the main list
                    if let index = cards.firstIndex(where: { $0.id == newCard.id }) {
                        cards[index] = newCard // Update the card in the main list
                    }
                }
            ))
            .presentationDetents([.fraction(0.5)]) // Show it half screen
            .presentationDragIndicator(.visible) // Visible drag indicator
        }
    }
}

// View for individual card
struct CardView: View {
    @Binding var card: Card          // Binding pro kartu
    @Binding var selectedCard: Card? // Binding pro vybranou kartu, aby se zobrazil modální pohled
    @State private var progress: Int

    // Vlastní inicializátor pro CardView
    init(card: Binding<Card>, selectedCard: Binding<Card?>) {
        self._card = card
        self._selectedCard = selectedCard
        self._progress = State(initialValue: card.wrappedValue.progress) // Inicializace progress
    }

    var body: some View {
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
                    CircularProgressView(progress: card.progress, lineWidth: 5, font: .system(size: 12, weight: .bold))
                        .frame(width: 40, height: 40)
                        .onTapGesture {
                            card.progress += progress <= 90 ? 10 : 0
                        }
                }
                .padding()
                .background(.gray.opacity(0.1))
                .cornerRadius(10)
                .shadow(radius: 5)
                .padding(.horizontal)
                .onTapGesture {
                    selectedCard = card // Nastavení vybrané karty pro zobrazení modálního okna
                }
            }
}


// View for Timer Settings
struct TimerSettingsView: View {
    @Binding var card: Card
    @State private var progress: Int
    
    private var cornerRadius = 20.0

    init(card: Binding<Card>) {
        self._card = card
        self._progress = State(initialValue: card.wrappedValue.progress) // Initialize progress
    }

    var body: some View {
        VStack() {
            Text(card.title)
                .font(.largeTitle)
                .bold()
            Text("Daily goal: \(card.goal)")
                .font(.subheadline)
            HStack {
                Button(action: {
                    // Decrease value
                    if progress >= 10 {
                        progress -= 10
                        card.progress = progress // Update the card's progress
                    }
                }) {
                    Image(systemName: "minus")
                        .frame(width: 40,height: 40)
                        .font(.subheadline)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(cornerRadius)
                }.padding(.horizontal)
                CircularProgressView(progress: progress,lineWidth: 15)
                .frame(width: 100, height: 100)
                
                Button(action: {
                    // Increase value
                    if progress <= 90 {
                        progress += 10
                        card.progress = progress // Update the card's progress
                    }
                }) {
                    Image(systemName: "plus")
                        .frame(width: 40,height: 40)
                        .font(.subheadline)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(cornerRadius)
                }.padding(.horizontal)
            }
            .padding(.vertical)
            HStack{
                Button(action: {
                    if progress > 0 {
                        progress = 0
                        card.progress = progress // Update the card's progress
                        
                    }
                }) {
                    Image(systemName: "arrow.uturn.backward")
                        .frame(width: 40,height: 40)
                        .font(.subheadline)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(cornerRadius/2)
                }
                .disabled(progress == 0)
                
                Button(action: {
                    if progress <= 95 {
                        progress += 5
                        card.progress = progress // Update the card's progress
                        
                    }
                }) {
                    Text("+5")
                        .frame(width: 40,height: 40)
                        .font(.subheadline)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(cornerRadius/2)
                }
                
                Button(action: {
                    if progress <= 90 {
                        progress += 10
                        card.progress = progress // Update the card's progress
                        
                    }
                }) {
                    Text("+10")
                        .frame(width: 40,height: 40)
                        .font(.subheadline)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(cornerRadius/2)
                }
                
                Button(action: {
                    if progress <= 80 {
                        progress += 20
                        card.progress = progress // Update the card's progress
                        
                    }
                }) {
                    Text("+20")
                        .frame(width: 40,height: 40)
                        .font(.subheadline)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(cornerRadius/2)
                }
            }
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity) // Ensure it takes max width
        .background(Color.white) // Just white color without edges
        .cornerRadius(0) // Remove rounding
        .shadow(radius: 0) // Remove shadow
        .onAppear {
            progress = card.progress // Sync progress with card's progress
        }
    }
}

#Preview {
    CardsView(cards: .constant([Card(iconName: "powersleep", title: "Sleep", color: .blue, goal: "8 hr ", progress: 70)]))
}
