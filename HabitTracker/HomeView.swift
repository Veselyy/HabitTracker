//
//  HomeView.swift
//  HabitTracker
//
//  Created by Martin Veselý on 25.09.2024.
//

import SwiftUI
import Charts

struct HomeView: View {
    
    @State private var progress = 0 // 30%
    
    let tabs: [TabBarItem] = [
        TabBarItem(iconName: "house", title: "Home"),
        TabBarItem(iconName: "chart.bar.fill", title: "History"),
        TabBarItem(iconName: "gear", title: "Settings")
    ]
    
    func Inkrement(){
        progress += progress == 100 ? 0 : 10
        
    }
    
    func Dekrement(){
        progress -= progress == 0 ? 0 : 10
    }
    
    var body: some View {
            NavigationStack {
                ZStack {
                    VStack {
                        CircularProgressView(progress: progress)
                            .padding()
                        
                        // Slider pro dynamickou změnu hodnoty (můžeš odebrat, pokud nechceš interakci)
                        HStack{
                            Button(action: {
                                Inkrement()
                            }) {
                                Image(systemName: "plus.circle")
                                    .font(.title)
                                    .foregroundColor(.black)
                            }.padding()
                            Button(action: {
                                Dekrement()
                            }) {
                                Image(systemName: "minus.circle")
                                    .font(.title)
                                    .foregroundColor(.black)
                            }.padding()
                        }.padding()
                        
                        Spacer()
                        CustomTabBarView(tabs: tabs)
                    }
                }
                .navigationTitle("Today")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            print("Levý button stisknut")
                        }) {
                            Text("Edit")
                        }
                        .foregroundColor(.black)
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
}

#Preview {
    NavigationStack {
        HomeView()
    }
}
