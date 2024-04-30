//
//  Little_LemonApp.swift
//  Little Lemon
//
//  Created by Siew Theng Chun on 27/4/2024.
//

import SwiftUI
import CoreData

@main
struct Little_LemonApp: App {
    
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                Color.background.ignoresSafeArea(edges: .all)
                Splash()
                    .preferredColorScheme(.light)
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
            
                
        }

    }
}

