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
       return !contact.name!.isEmpty && !contact.email!.isEmpty && !contact.company!.isEmpty
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
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button("Done") {
                                    
                                        dismiss()
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
    UpdateContactView(contact: Contact(name: "Benia", email: "bmorganware", company: "Apple"))
    
}

