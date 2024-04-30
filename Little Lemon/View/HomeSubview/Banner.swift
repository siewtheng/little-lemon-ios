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
        VStack(alignment: .leading, spacing: 0) {
            
            VStack(alignment: .leading, spacing: 0) {
                Text("Little Lemon")
                    .font(.markaziTextBold(50))
                    .fontWeight(.bold)
                    .foregroundColor(Color.primaryYellow)
                    .padding([.horizontal])
                
                HStack(alignment: .top, spacing: 5) {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Washington")
                            .font(.markaziTextSemiBold(30))
                            .fontWeight(.medium)
                            .foregroundColor(Color.background)
                            .padding(.top, 0)
                        
                        Text("Explore our wide range of dishes, from traditional classics to modern twists, all crafted with love and the finest ingredients.")
                            .font(.karlaMedium(15))
                            .foregroundColor(Color.background)
                            .padding(.top, 2)
                            .fixedSize(horizontal: false, vertical: true)
                        
                    }
                    
                    Spacer()
                    
                    Image("hero")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 120, height: 120)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                }
                .padding(.horizontal)
                
                
            }
            
            Spacer().frame(height: 10)
            
            TextField("Search Menu", text: $searchText)
                .padding()
                .background(Color.secondaryLightOrange)
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.secondaryOrange, lineWidth: 1)
                )
                .padding([.horizontal])
            
            
            Spacer()
            
        }
        .background(Color.primaryGreen)
        .padding(.bottom)
        
    }
}
