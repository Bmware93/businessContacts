//
//  AddNewContact.swift
//  businessContacts
//
//  Created by Benia Morgan-Ware on 8/26/23.
//

import SwiftUI
import SwiftData
import PhotosUI

struct AddNewContact: View {
    
    @Environment(\.modelContext) var context
    
    @Environment(\.dismiss) private var dismiss
    @State private var contactAvatarItem: PhotosPickerItem?
    @State private var contact = Contact(name: "", 
                                         email: "",
                                         company: "",
                                         contactImageData: nil)
    
    var isFormValid: Bool {
        return !contact.name!.isEmpty && !contact.email!.isEmpty && !contact.company!.isEmpty
    }
    
    var body: some View {
        NavigationStack {
            
                ZStack {
                    
                    Color.gray.opacity(0.1)
                        .ignoresSafeArea(.all)
                    
                    VStack {
                        if contact.contactImageData != nil {
                            let uiImage = UIImage(data: contact.contactImageData!)
                            Image(uiImage: uiImage!)
                                .resizable()
                                .clipShape(Circle())
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
                                .font(.system(size: 200))
                                .foregroundColor(.gray)
                                .padding(.top, 30)
                            
                            PhotosPicker("Add Photo", selection: $contactAvatarItem, matching: .images)
                                .buttonStyle(.bordered)
                                .buttonBorderShape(.capsule)
                        }
                        
                        Form {
                            
                            TextField("Full Name", text: $contact.name.defaultValue(""))
                            
                            TextField("Email", text: $contact.email.defaultValue(""))
                                .keyboardType(.emailAddress)
                            
                            TextField("Company", text: $contact.company.defaultValue(""))
                        }
                        .padding(.top)
                        .autocorrectionDisabled()
                        
                        Spacer()
                        
                            .toolbar {
                                ToolbarItem(placement: .navigationBarTrailing) {
                                    Button("Done") {
                                        withAnimation {
                                            if isFormValid {
                                                let newContact = Contact(name: contact.name, email: contact.email, company: contact.company, contactImageData: contact.contactImageData)
                                                
                                                context.insert(newContact)
                                                
                                                dismiss()
                                            }
                                        }
                                        
                                    }
                                    .bold()
                                    .disabled(!isFormValid)
                                    
                                }
                                ToolbarItem(placement: .navigationBarLeading) {
                                    Button("Cancel") {
                                        dismiss()
                                    }
                                    
                                }
                            }
                    }
                    .navigationTitle("New Contact")
                    .navigationBarTitleDisplayMode(.inline)
                    .onChange(of: contactAvatarItem) {
                        Task {
                            if let loaded  = try? await contactAvatarItem?.loadTransferable(type: Data.self) {
                                contact.contactImageData = loaded
                            } else {
                                print("Failed to Load Image")
                            }
                        }
                    }
                }
            }
            
        }
    }


#Preview {
    let preview = previewContainer([Contact.self])
    return AddNewContact().modelContainer(preview.container)
}
