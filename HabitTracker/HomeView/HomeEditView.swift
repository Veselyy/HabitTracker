import SwiftUI

struct HomeEditView: View {
    @Binding var cards: [Card]  // Binding pro karty
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    Text("Goals")
                        .font(.headline)
                        .fontWeight(.bold)
                        .padding(.top)
                    CardsView(cards: $cards, viewMode: .list)
                        .listRowInsets(EdgeInsets())
                }
                HStack {
                    Button(action: {
                        deleteCheckedCards()
                    }) {
                        Image(systemName: "trash")
                            
                        Text("Delete")
                    }
                    .foregroundStyle(!isAnyCardChecked() ? Color.secondary : Color.red)
                    .disabled(!isAnyCardChecked())
                    
                    Spacer()
                    if(isAnyCardChecked()){
                        Text("\(cards.filter { $0.isChecked }.count) selected")
                            .bold()
                    }
                    Spacer()
                    
                    Button(action: {
                        // TODO
                    }) {
                        Image(systemName: "archivebox")
                        Text("Archive")
                    }
                    .foregroundStyle(!isAnyCardChecked() ? Color.secondary : Color.blue)
                    .disabled(!isAnyCardChecked())
                }
                .padding()
            }
        }
    }
    
    // Funkce pro mazání vybraných karet
    private func deleteCheckedCards() {
        cards.removeAll { $0.isChecked }
    }
    
    // Funkce pro zjištění, zda je nějaká karta zaškrtnutá
    private func isAnyCardChecked() -> Bool {
        return cards.contains { card in
            card.isChecked
        }
    }
}

#Preview {
    HomeEditView(cards: .constant([
        Card(iconName: "powersleep", title: "Sleep", color: .blue, goal: "8 hr", progress: 0),
        Card(iconName: "drop.fill", title: "Drink Water", color: .green, goal: "5 l", progress: 0),
        Card(iconName: "checklist", title: "Review My Day", color: .red, goal: "1x", progress: 0)
    ]))
}
