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
    var font: Font? = .title.bold()

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

            Text(progress == 100 ? "✓" : "\(progress)%")
                .font(font)
                .foregroundColor(progress == 100 ? .green : .black)
        }
    }
}

#Preview {
    CircularProgressView(progress: 100)
}

