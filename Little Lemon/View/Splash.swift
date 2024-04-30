//
//  Splash.swift
//  Little Lemon
//
//  Created by Siew Theng Chun on 30/4/2024.
//

import SwiftUI

struct Splash: View {
    @State private var isShowingOnboarding = false
    
    var body: some View {
        
        VStack(spacing: 20) {
            Image("little-lemon-logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 250)
            
            ProgressView()
            
            Text("SiewTheng")
                .font(.karlaRegular(16))
        }
        .padding()
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    self.isShowingOnboarding = true
                }
            }
        }
        .fullScreenCover(isPresented: $isShowingOnboarding, content: {
            Onboarding()
            
        })
        .background(Color.background)
        
    }
        
}

#Preview {
    Splash()
}
