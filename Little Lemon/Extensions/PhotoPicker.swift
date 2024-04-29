//
//  PhotoPicker.swift
//  Little Lemon
//
//  Created by Siew Theng Chun on 29/4/2024.
//

import Foundation
import SwiftUI
import PhotosUI
import Photos

struct PhotoPicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    @Environment(\.presentationMode) var presentationMode
    @State private var hasPermission = false
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = context.coordinator
        
        checkPhotoLibraryPermission()
        
        return picker
        
        
    }
    
    private func checkPhotoLibraryPermission() {
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
            case .notDetermined:
                PHPhotoLibrary.requestAuthorization { status in
                    DispatchQueue.main.async {
                        self.hasPermission = (status == .authorized || status == .limited)
                    }
                }
            case .restricted, .denied:
                self.hasPermission = false
            case .authorized, .limited:
                self.hasPermission = true
            @unknown default:
                self.hasPermission = false
        }
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        // check permission again if needed or handle updates
        if !hasPermission {
            checkPhotoLibraryPermission()
        }
    }
    
    // coordinator class to handle PHPickerViewControllerDelegate methods
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        var parent: PhotoPicker
        
        init(parent: PhotoPicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            if let result = results.first {
                result.itemProvider.loadObject(ofClass: UIImage.self) { [self] (image, error) in
                    if let image = image as? UIImage {
                        parent.selectedImage = image
                    }
                }
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}
