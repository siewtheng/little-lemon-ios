//
//  Banner.swift
//  Little Lemon
//
//  Created by Siew Theng Chun on 29/4/2024.
//

import SwiftUI

struct Banner: View {
    @Binding var searchText: String

    var body: some View {
        VStack {
            TextField("Search menu", text: $searchText)
                .padding()
                .background(Color(.systemBackground))
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 1)
                )
                .padding()
        }
        .background(Color.blue.opacity(0.3))
    }
}
