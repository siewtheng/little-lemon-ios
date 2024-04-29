//
//  Home.swift
//  Little Lemon
//
//  Created by Siew Theng Chun on 28/4/2024.
//

import SwiftUI

struct Home: View {

    
    
    var body: some View {
        
        TabView {
            
            // menu tab
            Menu()
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
        
    }
}

#Preview {
    Home()
}
