import SwiftUI

// Model pro kartu
struct Card: Identifiable, Hashable {
    let id = UUID()
    let iconName: String
    let title: String
    let color: Color
    let goal: String
    var progress: Int
    var isChecked: Bool = false // Stav pro zaškrtnutí
}

struct CardView: View {
    @Binding var card: Card          // Binding pro kartu
    @Binding var selectedCard: Card?
    var viewMode: ViewMode

    // Už není potřeba explicitní inicializátor - SwiftUI si poradí s @Binding automaticky
    
    var body: some View {
        let backgroundColor = card.isChecked ? Color.blue.opacity(0.3) : (viewMode == .column ? Color.gray.opacity(0.1) : Color.white)
        let cornerRadius: CGFloat = viewMode == .column ? 10 : 0
        let shadowRadius: CGFloat = viewMode == .column ? 5 : 0
        let padding: CGFloat = viewMode == .column ? 16 : 0
        
        HStack {
            if viewMode == .list {
                Button(action: {
                    card.isChecked.toggle() // Přepíná stav `isChecked`
                }) {
                    Image(systemName: card.isChecked ? "checkmark.circle.fill" : "circle")
                        .foregroundColor(card.isChecked ? .white : .gray)
                }
                .buttonStyle(PlainButtonStyle()) // Zruší výchozí styl tlačítka
            }
            
            ZStack {
                Circle()
                    .fill(card.color.opacity(0.2))
                    .frame(width: 40, height: 40)
                Image(systemName: card.iconName)
                    .foregroundColor(card.color)
            }
            .padding(.trailing, 5)
            
            VStack {
                Text(card.title)
                    .font(viewMode == .column ? .headline : .body)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                if viewMode == .column {
                    Text("Goal: \(card.goal)")
                        .font(.system(size: 15))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            
            Spacer()
            if viewMode == .column {
                CircularProgressView(progress: card.progress, lineWidth: 5, font: .system(size: 12, weight: .bold))
                    .frame(width: 40, height: 40)
                    .onTapGesture {
                        incrementProgress()
                    }
            } else {
                Image(systemName: "line.3.horizontal")
                    .foregroundStyle(Color.gray)
            }
        }
        .padding()
        .background(backgroundColor)
        .cornerRadius(cornerRadius)
        .shadow(radius: shadowRadius)
        .padding(.horizontal, padding)
        .onTapGesture {
            if viewMode == .column {
                selectedCard = card
            }
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
    CardsView(cards: .constant([
        Card(iconName: "powersleep", title: "Sleep", color: .blue, goal: "8 hr", progress: 70),
        Card(iconName: "drop.fill", title: "Drink Water", color: .green, goal: "5 l", progress: 70),
        Card(iconName: "checklist", title: "Review My Day", color: .red, goal: "1x", progress: 70)
    ]), viewMode: .list)
}
