import SwiftUI

enum ViewMode: String {
    case list
    case column
}

// Main View for displaying multiple cards
struct CardsView: View {
    @Binding var cards: [Card] // Binding for cards
    @State private var selectedCard: Card? // Stores selected card for modal window
    @State public var viewMode: ViewMode = .column
    
    var body: some View {
        ForEach($cards) { $card in
            // Podmíněné použití gesta pro viewMode == .list
            CardView(card: $card, selectedCard: $selectedCard, viewMode: viewMode)
                .if(viewMode == .list) { view in
                    view.gesture(
                        DragGesture()
                            .onChanged { value in
                                // Získání aktuálního indexu karty
                                guard let sourceIndex = cards.firstIndex(where: { $0.id == card.id }) else { return }
                                let translation = value.translation
                                let newOffset = Int(translation.height / 50) // Měníme index podle výšky tazení

                                // Zajištění, že se index nachází v platných mezích
                                let destinationIndex = max(0, min(cards.count - 1, sourceIndex + newOffset))
                                
                                if destinationIndex != sourceIndex {
                                    withAnimation {
                                        cards.move(fromOffsets: IndexSet(integer: sourceIndex), toOffset: destinationIndex)
                                    }
                                }
                            }
                    )
                }
        }
        .onMove(perform: move)
        .listStyle(PlainListStyle())
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
    
    private func move(from indices: IndexSet, to newOffset: Int) {
        cards.move(fromOffsets: indices, toOffset: newOffset)
    }
}

#Preview {
    CardsView(cards: .constant([
        Card(iconName: "powersleep", title: "Sleep", color: .blue, goal: "8 hr", progress: 70),
        Card(iconName: "drop.fill", title: "Drink Water", color: .green, goal: "5 l", progress: 70),
        Card(iconName: "checklist", title: "Review My Day", color: .red, goal: "1x", progress: 70),
        Card(iconName: "powersleep", title: "Sleep", color: .blue, goal: "8 hr", progress: 70)
    ]), viewMode: .list)
}


extension View {
    /// Applies a transformation to the view based on a condition.
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
