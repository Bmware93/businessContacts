//
//  UpdateContactView.swift
//  businessContacts
//
//  Created by Benia Morgan-Ware on 12/3/23.
//

import SwiftUI
import SwiftData

struct UpdateContactView: View {
    
    @Environment(\.modelContext) var context
    
    
    @Environment(\.dismiss) private var dismiss
    @Bindable var contact: Contact
    
    var isFormValid: Bool {
        return !contact.name.isEmpty && !contact.email.isEmpty && !contact.company.isEmpty
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.gray.opacity(0.1)
                    .ignoresSafeArea()
                
                VStack {
                    Image(systemName:"person.crop.circle.fill")
                        .font(.system(size: 130))
                        .foregroundColor(.gray)
                        .padding(.top, 30)
                    
                    Text("Add Photo")
                        .font(.caption)
                    
                    
                    VStack {
                        Form {
                            TextField("Full Name", text: $contact.name)
                            
                            TextField("Email", text: $contact.email)
                                .keyboardType(.emailAddress)
                            
                            TextField("Company", text: $contact.company)
                        }
                    }
                    .padding(.top)
                    .autocorrectionDisabled()
                    
                    
                    Spacer()
                    
                        .toolbar {
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button("Done") {
                                    if isFormValid {
                                        dismiss()
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
                .navigationTitle("Update Contact")
                .navigationBarTitleDisplayMode(.inline)
            }
            
        }
    }
}

#Preview {
    UpdateContactView(contact: Contact(name: "Benia", email: "bmorganware", company: "Apple"))
}

