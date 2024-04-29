//
//  MenuItem.swift
//  Little Lemon
//
//  Created by Siew Theng Chun on 29/4/2024.
//

import SwiftUI

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
                
                Text(item.price.formattedAsCurrency())
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
                .frame(width: 80, height: 80)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            } else {
                Image(systemName: "dessert")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80, height: 80)
                    .foregroundColor(.gray)
            }
        }
        .padding()
    }
}
