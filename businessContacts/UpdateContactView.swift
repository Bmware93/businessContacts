//
//  UpdateContactView.swift
//  businessContacts
//
//  Created by Benia Morgan-Ware on 12/3/23.
//

import SwiftUI
import SwiftData
import PhotosUI


struct UpdateContactView: View {
    
    @Environment(\.modelContext) var context
    
    
    @Environment(\.dismiss) private var dismiss
    @Bindable var contact: Contact
    @State private var contactAvatarItem: PhotosPickerItem?
    
    
   var isFormValid: Bool {
       return !contact.name!.isEmpty && !contact.email!.isEmpty && !contact.company!.isEmpty
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.gray.opacity(0.1)
                    .ignoresSafeArea()
                
                VStack {
                    if contact.contactImageData != nil {
                        let uiImage = UIImage(data: contact.contactImageData!)
                        Image(uiImage: uiImage!)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 300)
                        
                        Button("Remove Image", role: .destructive) {
                            withAnimation {
                                contactAvatarItem = nil
                                contact.contactImageData = nil
                            }
                        }
                        .buttonStyle(.bordered)
                        .buttonBorderShape(.capsule)
                        
                    } else {
                        Image(systemName:"person.crop.circle.fill")
                            .font(.system(size: 130))
                            .foregroundColor(.gray)
                            .padding(.top, 30)
                        
                        PhotosPicker("Add Photo", selection: $contactAvatarItem, matching: .images)
                            .buttonStyle(.bordered)
                            .buttonBorderShape(.capsule)
                    }
                    
                    VStack {
                        Form {
                            TextField("Full Name", text: $contact.name.defaultValue("Unknown"))
                            
                            TextField("Email", text: $contact.email.defaultValue("Unknown"))
                                .keyboardType(.emailAddress)
                            
                            TextField("Company", text: $contact.company.defaultValue("Unknown"))
                        }
                    }
                    .padding(.top)
                    .autocorrectionDisabled()
                    
                    Spacer()
                    
                        .toolbar {
                            ToolbarItem(placement: .confirmationAction) {
                                Button("Done") {
                                    withAnimation {
                                        
                                        dismiss()
                                    }
                                }
                                .bold()
                                .disabled(!isFormValid)
                            }
                        }
                }
                .navigationTitle("Update Contact")
                .navigationBarTitleDisplayMode(.inline)
            }
            
        }
    }
}

extension Binding {
    public func defaultValue<T>(_ value: T) -> Binding<T> where Value == Optional<T> {
        Binding<T> {
            wrappedValue ?? value
        } set: {
            wrappedValue = $0
        }
    }
}

#Preview {
    let preview = previewContainer([Contact.self])
    return UpdateContactView(contact: Contact(name: "", email: "", company: "", contactImageData: nil)).modelContainer(preview.container)
}

