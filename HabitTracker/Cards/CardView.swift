import SwiftUI

// Model pro kartu
struct Card: Identifiable, Hashable {
    let id = UUID()
    let iconName: String
    let title: String
    let color: Color
    let goal: String
    var progress: Int
    var isChecked: Bool = false
}

struct CardView: View {
    @Binding var card: Card
    @Binding var selectedCard: Card?
    @State private var timer: Timer? = nil
    @State private var isLongPressing: Bool = false // Sledování stavu dlouhého stisku
    @State private var dragOffset = CGSize.zero // Stav pro sledování gesta
    
    var viewMode: ViewMode
    
    var body: some View {
        let backgroundColor = card.isChecked ? Color.blue.opacity(0.3) : Color("ViewModeColor")
        let cornerRadius: CGFloat = viewMode == .column ? 10 : 0
        let shadowRadius: CGFloat = viewMode == .column ? 5 : 0
        let padding: CGFloat = viewMode == .column ? 16 : 0
        
        HStack {
            if viewMode == .list {
                Image(systemName: card.isChecked ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(card.isChecked ? .primary : .secondary)
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
                        incrementProgress() // Při krátkém kliknutí zvýšíme hodnotu o 10
                    }
                    .gesture(
                        DragGesture(minimumDistance: 0) // Použijeme `DragGesture` místo `LongPressGesture`
                            .onChanged { _ in
                                handlePress() // Spustí se při detekci stisku
                            }
                            .onEnded { _ in
                                handleRelease() // Zastaví se po uvolnění stisku
                            }
                    )
                
            } else {
                Image(systemName: "line.3.horizontal")
                    .foregroundStyle(Color.secondary)
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
            else{
                card.isChecked.toggle()
            }
        }
    }
    
    // Funkce pro inkrementaci progressu při krátkém kliknutí
    private func incrementProgress() {
        if card.progress <= 90 {
            card.progress += 10
        }
    }
    
    // Funkce pro zpracování stisku tlačítka
    private func handlePress() {
        isLongPressing = true
        DispatchQueue.main.asyncAfter(deadline: .now()) { // Zpoždění 2 sekundy
            if isLongPressing { // Pokud uživatel stále drží tlačítko po 2 sekundách
                startTimer()
            }
        }
    }
    
    // Funkce pro zpracování uvolnění tlačítka
    private func handleRelease() {
        isLongPressing = false // Přestáváme sledovat dlouhý stisk
        stopTimer() // Zastavíme timer, pokud běží
    }
    
    // Funkce pro spuštění časovače při dlouhém podržení
    private func startTimer() {
        stopTimer() // Zastavíme případný běžící timer, abychom předešli duplikaci
        timer = Timer.scheduledTimer(withTimeInterval: 0.001, repeats: true) { _ in
            if card.progress <= 99 {
                card.progress += 1
            } else {
                stopTimer()
            }
        }
    }
    
    // Funkce pro zastavení časovače při uvolnění tlačítka
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
        isLongPressing = false // Nastavíme zpět na `false`, když timer zastavíme
    }
}

#Preview {
    CardsView(cards: .constant([
        Card(iconName: "powersleep", title: "Sleep", color: .blue, goal: "8 hr", progress: 70),
        Card(iconName: "drop.fill", title: "Drink Water", color: .green, goal: "5 l", progress: 70),
        Card(iconName: "checklist", title: "Review My Day", color: .red, goal: "1x", progress: 70)
    ]), viewMode: .list)
}
