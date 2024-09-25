//
//  HomeView.swift
//  HabitTracker
//
//  Created by Martin Veselý on 25.09.2024.
//

import SwiftUI
import Charts

struct HomeView: View {
    var body: some View {
        NavigationStack{
            ScrollView{
                
            }
        }.navigationTitle("Today")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        print("Levý button stisknut")
                    }) {
                        Text("Edit")
                    }.foregroundColor(.black)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        print("Pravý button stisknut")
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.black)
                    }
                }
            }
    }
}

#Preview {
    NavigationStack{
        HomeView()
    }
}
