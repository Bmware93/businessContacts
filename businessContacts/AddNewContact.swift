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
    @State var name: String = ""
    @State var email: String = ""
    @State var company: String = ""
    @State private var contactAvatarItem: PhotosPickerItem?
    @State private var contactAvatarImage: Image?
    
    var isFormValid: Bool {
        return !name.isEmpty && !email.isEmpty && !company.isEmpty
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.gray.opacity(0.1)
                    .ignoresSafeArea(.all)
                
                VStack {
                    if let contactAvatarImage {
                        
                        contactAvatarImage
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 300)
                        
                    } else {
                        Image(systemName:"person.crop.circle.fill")
                            .font(.system(size: 130))
                            .foregroundColor(.gray)
                            .padding(.top, 30)
                    }
                    
                    PhotosPicker("Add Photo", selection: $contactAvatarItem, matching: .images)
                        .buttonStyle(.bordered)
                        .buttonBorderShape(.capsule)
                    
                    Form {
                        TextField("Full Name", text: $name)
                        
                        TextField("Email", text: $email)
                            .keyboardType(.emailAddress)
                        
                        TextField("Company", text: $company)
                    }
                    .padding(.top)
                    .autocorrectionDisabled()
                    
                    Spacer()
                    
                        .toolbar {
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button("Done") {
                                    withAnimation {
                                        if isFormValid {
                                            let newContact = Contact(name: name, email: email, company: company)
                                            
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
            }
            
        }
    }
}

struct AddNewContact_Previews: PreviewProvider {
    static var previews: some View {
        AddNewContact()
    }
}
