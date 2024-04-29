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
    @State private var searchText = "" //search
    @StateObject private var viewModel = MenuViewModel() //category selector
    
    @FetchRequest var menuItems: FetchedResults<MenuData>
    
    var body: some View {
        VStack {
            // Banner View for Search
            Banner(searchText: $searchText)
            
            // Category Buttons
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(viewModel.categories, id: \.self) { category in
                        Button(action: {
                            viewModel.selectCategory(category)
                            updateFetchRequest()
                        }) {
                            Text(category.capitalized)
                                .padding()
                                .background(viewModel.isSelected(category: category) ? Color.blue : Color.gray)
                                .foregroundColor(.white)
                                .cornerRadius(10)

                        }
                    }
                }
                .padding(.horizontal)
            }
            .onChange(of: viewModel.selectedCategory) {
                updateFetchRequest()
            }
            
            
            
            if isLoading {
                ProgressView("Loading...")
            } else {
                List(menuItems, id: \.self) { item in
                    MenuItemView(item: MenuItem(
                        title: item.title ?? "",
                        description: item.desc ?? "",
                        price: item.price ?? "0",
                        image: item.image ?? "",
                        category: item.category ?? "food"))
                }
            }
        }
        .onAppear {
            checkAndFetchData()
        }
    }
    
    private func checkAndFetchData() {
        let fetchRequest: NSFetchRequest<MenuData> = MenuData.fetchRequest()
        fetchRequest.predicate = PredicateUtility.buildPredicate(for: searchText, category: viewModel.selectedCategory) // apply the predicate
        fetchRequest.sortDescriptors = [SortUtilities.titleSortDescriptor()] // apply sorting
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
    
    private func updateFetchRequest() {
        menuItems.nsPredicate = PredicateUtility.buildPredicate(for: searchText, category: viewModel.selectedCategory)
    }
    
    init() {
        _menuItems = FetchRequest<MenuData>(
            sortDescriptors: [NSSortDescriptor(keyPath: \MenuData.title, ascending: true)],
            animation: .default)
    }
    
}


#Preview {
    Menu()
}
