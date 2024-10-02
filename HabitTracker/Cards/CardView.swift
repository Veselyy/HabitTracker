import SwiftUI

// Model pro kartu
struct Card: Identifiable, Hashable {
    let id = UUID()
    let iconName: String
    let title: String
    let color: Color
    let goal: String
    var progress: Int
}

struct CardView: View {
    @Binding var card: Card          // Binding pro kartu
    @Binding var selectedCard: Card? // Binding pro vybranou kartu, aby se zobrazil modální pohled

    // Vlastní inicializátor pro CardView
    init(card: Binding<Card>, selectedCard: Binding<Card?>) {
        self._card = card
        self._selectedCard = selectedCard
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
                    incrementProgress()
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

    // Funkce pro inkrementaci progress
    private func incrementProgress() {
        if card.progress <= 90 {
            card.progress += 10
        }
    }
}

#Preview {
    
    CardView(
        card: .constant(Card(iconName: "star", title: "Test Card", color: .blue, goal: "100%", progress: 50)),
        selectedCard: .constant(nil)
    )
}
