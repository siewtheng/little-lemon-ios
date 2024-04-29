//
//  Menu.swift
//  Little Lemon
//
//  Created by Siew Theng Chun on 29/4/2024.
//

import SwiftUI
import Combine

struct Menu: View {
    
    @State private var menuItems: [MenuItem] = []
    @State private var isLoading = true
    
    
    var body: some View {
        VStack {
            // header
            Text("Home")
                .font(.largeTitle)
            
            if isLoading {
                ProgressView("Loading...")
            }
            
            // banner
            Text("Hello")
            
            // category
            Text("Hello")
            
            // menu list
            List(menuItems, id: \.id) { item in
                MenuItemView(item: item)
            }
            
        }
        .onAppear {
            
            getMenuData()
            
        }
        
    }
    
    func getMenuData() {
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
                            self.menuItems = decodedResponse.menu
                            self.isLoading = false
                        }
                    } catch {
                        print("JSON decoding failed: \(error)")
                    }
                } else if let error = error {
                    print("Fetch failed: \(error.localizedDescription)")
                }
            }.resume()
        }
    
    
    
}

struct MenuItemView: View {
    let item: MenuItem
    
    var body: some View {
        HStack {
            // Text details on the left
            VStack(alignment: .leading) {
                Text(item.title)
                    .font(.headline)
                
                Text(item.description)
                    .font(.subheadline)
                    .lineLimit(2)
                    .truncationMode(.tail)
                
                Text("Price: \(item.price)")
                    .font(.caption)
            }
            .padding(.trailing, 10)
            
            Spacer()

            // Image on the right
            if let url = URL(string: item.image), !item.image.isEmpty {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 100, height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .foregroundColor(.gray)
            }
        }
        .padding()
    }
}

#Preview {
    Menu()
}
