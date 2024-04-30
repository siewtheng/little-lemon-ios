//
//  Home.swift
//  Little Lemon
//
//  Created by Siew Theng Chun on 28/4/2024.
//

import SwiftUI

struct Home: View {
    
    // persistence controller constant - core data
    let persistence = PersistenceController.shared
    
    init() {
        // Set the appearance of the UITabBar
        UITabBar.appearance().backgroundColor = UIColor.white
    }
    
    var body: some View {
        
        TabView {
            
            // menu tab
            Menu()
                .environment(\.managedObjectContext, persistence.container.viewContext)
                .tabItem {
                    Label("Menu", systemImage: "list.dash")
                }
            
            
            // profile tab
            UserProfile()
                .tabItem {
                    Label("Profile", systemImage: "square.and.pencil")
                }
            
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            // reinforce the tab bar background color when the view appears
            UITabBar.appearance().backgroundColor = UIColor.white
        }
    }
}

#Preview {
    Home()
}
