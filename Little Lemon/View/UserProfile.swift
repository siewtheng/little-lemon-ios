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
            Text("Personal Information")
                .font(.title)
                .padding()
            
            // profile image
            if let image = selectedImage ?? profileImage {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
                    .shadow(radius: 10)
            }
            
            // image photo picker
            Button("Select Profile Picture") {
                // present photo picker
                isShowingPhotoPicker = true
            }
            .padding()
            .sheet(isPresented: $isShowingPhotoPicker) {
                PhotoPicker(selectedImage: $selectedImage)
            }
            
            // fields
            VStack(spacing: 10) {
                VStack(alignment: .leading, spacing: 2) {
                    Text("First Name")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(.secondary)
                    TextField("First Name", text: $tempFirstName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                VStack(alignment: .leading, spacing: 2) {
                    Text("Last Name")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(.secondary)
                    TextField("Enter your last name", text: $tempLastName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                VStack(alignment: .leading, spacing: 2) {
                    Text("Email")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(.secondary)
                    TextField("Enter your email", text: $tempEmail)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .textContentType(.emailAddress)
                        .textInputAutocapitalization(.never)
                }
                
            }
            
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
            .padding()
            
            // logout Button
            Button("Logout") {
                // remove user details from UserDefaults
                UserDefaults.standard.removeObject(forKey: kFirstName)
                UserDefaults.standard.removeObject(forKey: kLastName)
                UserDefaults.standard.removeObject(forKey: kEmail)
                
                // dismiss the UserProfile view
                self.presentation.wrappedValue.dismiss()
            }
            .padding()
            
            
            Spacer()
            
        }
        .padding()
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
