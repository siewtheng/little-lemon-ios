//
//  MenuItem.swift
//  Little Lemon
//
//  Created by Siew Theng Chun on 29/4/2024.
//

import Foundation

struct MenuItem: Decodable {
    let id: Int
    let title: String
    let description: String
    let price: String
    let image: String
    let category: String
}
