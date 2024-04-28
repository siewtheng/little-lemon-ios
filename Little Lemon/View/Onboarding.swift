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
            
            VStack {
                
                // little lemon logo
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 50)
                
                // label
                Text("Welcome to Little Lemon Restaurant !")
                    .font(.title2)
                    .fontWeight(.bold)
                    .italic()
                    .padding()
                
                // little lemon restaurant picture
                Image("restaurant")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 100)
                   
                Spacer().frame(height: 50)
                
                // textfields for user details
                TextField("First Name", text: $firstName)
                TextField("Last Name", text: $lastName)
                TextField("Email", text: $email)
                    .textContentType(.emailAddress)
                    .textInputAutocapitalization(.never)
                
                
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
                        print("Email is not valid")
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

                Spacer()
                
            }
            .padding()
        }
        
        
    }
}

#Preview {
    Onboarding()
}
