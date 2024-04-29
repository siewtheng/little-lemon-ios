//
//  Menu.swift
//  Little Lemon
//
//  Created by Siew Theng Chun on 29/4/2024.
//

import SwiftUI
import CoreData

struct Menu: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @State private var isLoading = true
    
    
    var body: some View {
        VStack {
            if isLoading {
                ProgressView("Loading...")
            } else {
                FetchedObjects(
                    sortDescriptors: [NSSortDescriptor(keyPath: \MenuData.title, ascending: true)],
                    content: { (menuItems: [MenuData]) in
                        List(menuItems, id: \.title) { item in
                            MenuItemView(item: MenuItem(title: item.title ?? "", description: item.desc ?? "", price: item.price ?? "0", image: item.image ?? "", category: item.category ?? "food"))
                        }
                    }
                )
            }
            
        }
        .onAppear {
            checkAndFetchData()
        }
    }
    
    private func checkAndFetchData() {
        let fetchRequest: NSFetchRequest<MenuData> = MenuData.fetchRequest()
        let count = (try? viewContext.count(for: fetchRequest)) ?? 0
        
        if count == 0 {
            // No data in database, fetch from URL
            fetchMenuDataFromURL()
        } else {
            // Data is available in CoreData, no need to fetch
            self.isLoading = false
        }
    }
    
    private func fetchMenuDataFromURL() {
        let urlString = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode(MenuList.self, from: data)
                    DispatchQueue.main.async {
                        self.isLoading = false
                        self.saveMenuItemsToDatabase(items: decodedResponse.menu)
                    }
                } catch {
                    print("JSON decoding failed: \(error)")
                }
            } else if let error = error {
                print("Fetch failed: \(error.localizedDescription)")
            }
        }.resume()
    }
    
    private func saveMenuItemsToDatabase(items: [MenuItem]) {
        for item in items {
            let newMenuData = MenuData(context: viewContext)
            newMenuData.title = item.title
            newMenuData.desc = item.description
            newMenuData.image = item.image
            newMenuData.price = item.price
            newMenuData.category = item.category
        }
        
        do {
            try viewContext.save()
        } catch {
            print("Failed to save to Core Data: \(error.localizedDescription)")
        }
    }
    
}



#Preview {
    Menu()
}
