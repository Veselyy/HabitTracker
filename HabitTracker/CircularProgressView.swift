//
//  CircularProgressView.swift
//  HabitTracker
//
//  Created by Martin Veselý on 26.09.2024.
//

import SwiftUI

struct CircularProgressView: View {
    var progress: Int // Procenta
    var lineWidth: CGFloat = 20.0 // Tloušťka kruhu

    // Computed property pro zobrazení textu
    var textPercentage: String {
        "\(min(progress, 100))%"
    }
    
    var imagePercentage: Image {
        Image(systemName: "checkmark")
    }
    
    // Funkce vrací univerzální `View` pomocí `AnyView`
    func Complete() -> AnyView {
        if progress == 100 {
            return AnyView(imagePercentage
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.green))
        } else {
            return AnyView(Text(textPercentage)
                            .font(.system(size: 40, weight: .bold))
                            .foregroundColor(.black))
        }
    }

    var body: some View {
        ZStack {
            // Pozadí (šedý kruh)
            Circle()
                .stroke(Color.gray.opacity(0.2), lineWidth: lineWidth)

            // Progres kruh s barevným přechodem
            Circle()
                .trim(from: 0, to: CGFloat(min(progress, 100)) / 100) // Převod na hodnotu 0 - 1
                .stroke(
                    progress == 100 ? Color.green : Color.black, // Barva
                    style: StrokeStyle(lineWidth: lineWidth, lineCap: .round)
                )
                .rotationEffect(.degrees(-90)) // Otočení, aby začínalo nahoře
                .animation(.easeInOut, value: progress)

            // Zobrazení uprostřed, které se mění podle `progress`
            Complete() // Vložený výsledek funkce `Complete`
        }
        .frame(width: 150, height: 150) // Velikost grafu
    }
}

#Preview {
    CircularProgressView(progress: 100)
}
