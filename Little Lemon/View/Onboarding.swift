//
//  Onboarding.swift
//  Little Lemon
//
//  Created by Siew Theng Chun on 28/4/2024.
//

import SwiftUI

// keys for UserDefaults
let kFirstName = "first_name_key"
let kLastName = "last_name_key"
let kEmail = "email_key"

struct Onboarding: View {
    
    // variables
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    @State private var navigationPath = NavigationPath()
    
    var body: some View {
        
        NavigationStack(path: $navigationPath) {
            
            VStack(spacing: 10) {
                
                // little lemon logo
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 50)
                
                // label
                Text("Welcome to Little Lemon Restaurant !")
                    .font(.karlaExtraBold(22))
                    .multilineTextAlignment(.center)
                    .foregroundStyle(Color.secondaryOrange)
                    .padding()
                
                // little lemon restaurant picture
                Image("restaurant")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 100)
                    .frame(width: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer().frame(height: 20)
                
                // textfields for user details
                VStack(alignment: .leading, spacing: 8) {
                    Text("First Name")
                        .font(.karlaExtraBoldItalic(18))
                        .foregroundStyle(Color.text)
                    TextField("First Name", text: $firstName)
                        .padding()
                        .font(.karlaRegular(16))
                        .cornerRadius(8)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.secondaryOrange, lineWidth: 1)
                        )
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Last Name")
                        .font(.karlaExtraBoldItalic(18))
                        .foregroundStyle(Color.text)
                    TextField("Last Name", text: $lastName)
                        .padding()
                        .font(.karlaRegular(16))
                        .cornerRadius(8)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.secondaryOrange, lineWidth: 1)
                        )
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Email")
                        .font(.karlaExtraBoldItalic(18))
                        .foregroundStyle(Color.text)
                    TextField("Email", text: $email)
                        .padding()
                        .font(.karlaRegular(16))
                        .cornerRadius(8)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.secondaryOrange, lineWidth: 1)
                        )
                        .textContentType(.emailAddress)
                        .autocapitalization(.none)
                }
                
                Spacer().frame(height: 10)
                
                // register button
                Button("Register") {
                    if !firstName.isEmpty && !lastName.isEmpty && !email.isEmpty && EmailValidator.isValidEmail(email) {
                        // email is valid
                        // store user details in UserDefaults
                        UserDefaults.standard.set(firstName, forKey: kFirstName)
                        UserDefaults.standard.set(lastName, forKey: kLastName)
                        UserDefaults.standard.set(email, forKey: kEmail)
                        
                        // navigation to home
                        navigationPath.append(NavigationItem.home)
                        
                        
                    } else {
                        // email is not valid or other fields are empty
                        print("Email is not valid or other fields are empty")
                    }
                }
                .disabled(firstName.isEmpty || lastName.isEmpty || email.isEmpty || !EmailValidator.isValidEmail(email))
                .navigationDestination(for: NavigationItem.self) { item in
                    switch item {
                    case .home:
                        Home()
                    case .profile:
                        UserProfile()
                    }
                }
                .font(.karlaBold(18))
                .frame(maxWidth: .infinity)
                .padding()
                .foregroundColor(firstName.isEmpty || lastName.isEmpty || email.isEmpty || !EmailValidator.isValidEmail(email) ? Color.text : Color.background)

                .background(
                    Group {
                        if !firstName.isEmpty && !lastName.isEmpty && !email.isEmpty && EmailValidator.isValidEmail(email) {
                            // button enabled, use white background
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.primaryGreen)
                        } else {
                            // Button disabled, use green border
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.primaryGreen, lineWidth: 1)
                        }
                    }
                )
                
                
                Spacer()
                
            }
            .padding(.top, 5)
            .padding(.horizontal, 20)
            .background(Color.background)
        }
        
        
    }
}

#Preview {
    Onboarding()
}
