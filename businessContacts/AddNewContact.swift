//
//  AddNewContact.swift
//  businessContacts
//
//  Created by Benia Morgan-Ware on 8/26/23.
//

import SwiftUI
import SwiftData

struct AddNewContact: View {
    
    @Environment(\.modelContext) var context
    
    
    @Environment(\.dismiss) private var dismiss
    @State var name: String = ""
    @State var email: String = ""
    @State var company: String = ""
    
    var isFormValid: Bool {
        return !name.isEmpty && !email.isEmpty && !company.isEmpty
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.gray.opacity(0.1)
                    .ignoresSafeArea(.all)
                
                VStack {
                    Image(systemName:"person.crop.circle.fill")
                        .font(.system(size: 130))
                        .foregroundColor(.gray)
                        .padding(.top, 30)

                    
                    Button("Add Photo") {
                        //code to add photo to go here
                    }
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
