import SwiftUI

// Main View for displaying multiple cards
struct CardsView: View {
    @Binding var cards: [Card] // Binding for cards
    @State private var selectedCard: Card? // Stores selected card for modal window

    var body: some View {
        VStack {
            ForEach($cards) { $card in
                CardView(card: $card, selectedCard: $selectedCard)
            }
        }
        .sheet(item: $selectedCard) { card in
            CardProgressView(card: Binding<Card>(
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

    // Funkce pro mazání karet
    private func deleteCards(at offsets: IndexSet) {
        cards.remove(atOffsets: offsets)
    }
}

#Preview {
    CardsView(cards: .constant([Card(iconName: "powersleep", title: "Sleep", color: .blue, goal: "8 hr ", progress: 70)]))
}

