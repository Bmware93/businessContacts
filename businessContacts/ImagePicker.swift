//
//  ImagePicker.swift
//  businessContacts
//
//  Created by Benia Morgan-Ware on 12/8/23.
//

import PhotosUI
import SwiftUI


struct ImagePicker: View {
    @State private var avatarItem: PhotosPickerItem?
    @State private var avatarImage: Image?
    
    var body: some View {
        VStack {
            PhotosPicker("Select Image", selection: $avatarItem, matching: .images)
            
            avatarImage?
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 300)
        }
        .onChange(of: avatarItem) {
            Task {
                if let loaded = try? await avatarItem?.loadTransferable(type: Image.self) {
                    avatarImage = loaded
                } else {
                    print("Failed")
                }
            }
        }
    }
}

#Preview {
    ImagePicker()
}


