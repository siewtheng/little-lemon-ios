//
//  UserProfile.swift
//  Little Lemon
//
//  Created by Siew Theng Chun on 29/4/2024.
//

import SwiftUI

struct UserProfile: View {
    
    // UserDefaults info
    @State private var firstName: String = UserDefaults.standard.string(forKey: kFirstName) ?? ""
    @State private var lastName: String = UserDefaults.standard.string(forKey: kLastName) ?? ""
    @State private var email: String = UserDefaults.standard.string(forKey: kEmail) ?? ""
    
    @State private var tempFirstName: String = ""
    @State private var tempLastName: String = ""
    @State private var tempEmail: String = ""
    
    // presentation mode
    @Environment(\.presentationMode) var presentation
    
    // image
    @State private var profileImage: UIImage? = nil // hold the userprofile image
    @State private var selectedImage: UIImage? // hold the selected image from the picker
    @State private var isShowingPhotoPicker: Bool = false // control the presentation of the PhotoPicker sheet
    
    // save
    @State private var showingSaveAlert = false
    
    var body: some View {
        VStack {
            // display screen title
            Text("Profile")
                .font(.markaziTextBold(20))
                .fontWeight(.bold)
                .padding()
            
            // profile image
            if let image = selectedImage ?? profileImage {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
                    .shadow(radius: 10)
            }
            
            // image photo picker
            Button("Select Profile Picture") {
                // present photo picker
                isShowingPhotoPicker = true
            }
            .padding(8)
            .sheet(isPresented: $isShowingPhotoPicker) {
                PhotoPicker(selectedImage: $selectedImage)
            }
            .foregroundColor(Color.text)
            .background(RoundedRectangle(cornerRadius: 10)
                .fill(Color.primaryYellow))
            
            Spacer().frame(height: 20)
            
            // fields
            VStack(alignment: .leading, spacing: 8) {
                Text("First Name")
                    .font(.karlaExtraBoldItalic(18))
                    .foregroundStyle(Color.text)
                TextField("First Name", text: $tempFirstName)
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
                TextField("Enter your last name", text: $tempLastName)
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
                TextField("Enter your email", text: $tempEmail)
                    .padding()
                    .font(.karlaRegular(16))
                    .cornerRadius(8)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.secondaryOrange, lineWidth: 1)
                    )
                    .textContentType(.emailAddress)
                    .textInputAutocapitalization(.never)
            }
            
            Spacer().frame(height: 20)
            
            // save changes
            Button("Save") {
                // Save the changes to UserDefaults
                UserDefaults.standard.set(firstName, forKey: "kFirstName")
                UserDefaults.standard.set(lastName, forKey: "kLastName")
                UserDefaults.standard.set(email, forKey: "kEmail")
                if let selectedImage = selectedImage {
                    profileImage = selectedImage
                }
                showingSaveAlert = true
            }
            .disabled(firstName.isEmpty || lastName.isEmpty || email.isEmpty || !EmailValidator.isValidEmail(email))
            .padding(8)
            .frame(maxWidth: .infinity)
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
            
            // logout Button
            Button("Logout") {
                // remove user details from UserDefaults
                UserDefaults.standard.removeObject(forKey: kFirstName)
                UserDefaults.standard.removeObject(forKey: kLastName)
                UserDefaults.standard.removeObject(forKey: kEmail)
                
                // dismiss the UserProfile view
                self.presentation.wrappedValue.dismiss()
            }
            .padding(8)
            .frame(maxWidth: .infinity)
            .foregroundColor(Color.text)
            .background(RoundedRectangle(cornerRadius: 10)
                .fill(Color.error))
            
            Spacer()
            
        }
        .padding(.top, 5)
        .padding(.horizontal, 20)
        .background(Color.background)
        .onAppear {
            tempFirstName = UserDefaults.standard.string(forKey: kFirstName) ?? ""
            tempLastName = UserDefaults.standard.string(forKey: kLastName) ?? ""
            tempEmail = UserDefaults.standard.string(forKey: kEmail) ?? ""
            profileImage = defaultProfileImage()
        }
        .alert(isPresented: $showingSaveAlert) {
            Alert(
                title: Text("Saved Successfully"),
                message: Text("Your changes have been saved."),
                dismissButton: .default(Text("OK"))
            )
        }
        
    }
    
    // create default profile image with user's initials
    private func defaultProfileImage() -> UIImage {
        let initials = "\(firstName.first ?? "A")\(lastName.first ?? "B")"
        let size = CGSize(width: 200, height: 200)
        return UIImage.makeInitialsImage(initials: initials, size: size)
    }
    
    // save changes
    func saveChanges() {
        UserDefaults.standard.set(tempFirstName, forKey: kFirstName)
        UserDefaults.standard.set(tempLastName, forKey: kLastName)
        UserDefaults.standard.set(tempEmail, forKey: kEmail)
        if let selectedImage = selectedImage {
            profileImage = selectedImage
        }
        showingSaveAlert = true
    }
    
}


#Preview {
    UserProfile()
}
