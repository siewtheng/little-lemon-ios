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
        VStack(spacing: 5) {
            
            // header
            Header()
            
            // Banner View for Search
            Banner(searchText: $searchText)
            
            // Category Buttons
            ScrollView(.horizontal, showsIndicators: false) {
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("ORDER FOR DELIVERY !")
                        .font(.karlaExtraBold(20))
                        .padding(.horizontal)
                        .padding(.top, -10)
                    
                    
                    HStack {
                        ForEach(viewModel.categories, id: \.self) { category in
                            Button(action: {
                                viewModel.selectCategory(category)
                            }) {
                                Text(category.capitalized)
                                    .padding(10)
                                    .background(viewModel.isSelected(category: category) ? Color.secondaryOrange : Color.text)
                                    .foregroundColor(viewModel.isSelected(category: category) ? Color.text : .white)
                                    .cornerRadius(10)
                                
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.top, 10)
                
            }
            .background(Color.background)
            
            
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
                    .background(Color.background)
                    .listRowBackground(Color.background)
                }
                .listStyle(PlainListStyle())
                .listRowBackground(Color.background)
                .background(Color.background)
            }
        }
        .onAppear {
            checkAndFetchData()
        }
        .background(Color.background)
        .onChange(of: searchText) {
            updateFetchRequest()
        }
        .onChange(of: viewModel.selectedCategory) {
            updateFetchRequest()
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
