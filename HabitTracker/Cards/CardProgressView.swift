//
//  CardProgressView.swift
//  HabitTracker
//
//  Created by Martin Veselý on 02.10.2024.
//

import SwiftUI

struct CardProgressView: View {
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
    CardProgressView(card: .constant(Card(iconName: "star", title: "Test Card", color: .blue, goal: "100%", progress: 50)))
}
