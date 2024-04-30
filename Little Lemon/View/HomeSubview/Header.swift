//
//  Header.swift
//  Little Lemon
//
//  Created by Siew Theng Chun on 30/4/2024.
//

import SwiftUI

struct Header: View {
    var body: some View {
        Image("logo")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: 50)
    }
}

#Preview {
    Header()
}
