//
//  AddNewContact.swift
//  businessContacts
//
//  Created by Benia Morgan-Ware on 8/26/23.
//

import SwiftUI

struct AddNewContact: View {
    //@EnvironmentObject var viewModel: ContactViewModel
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
                    .ignoresSafeArea()
                
                VStack {
                    Image(systemName:"person.crop.circle.fill")
                        .font(.system(size: 130))
                        .foregroundColor(.gray)
                        .padding(.top, 30)
                    
                    Text("Add Photo")
                        .font(.caption)
                    
                    //Spacer()
                    
                    VStack {
                        TextField("Full Name", text: $name, prompt: Text("Full Name"))
                            
                       
                        TextField("Email", text: $email, prompt: Text("Email"))
                       
                        TextField("Company", text: $company, prompt: Text("Company"))
                        
                    }
                    .padding(.top)
                    .padding(.leading)
                    //.keyboardType(.default)
                    .textFieldStyle(.roundedBorder)
                    .autocorrectionDisabled()
                   
                    
                    Spacer()
                    
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button("Done") {
                                if isFormValid {
                                    let newContact = Contact(name: name, email: email, company: company)
                                    
                                    context.insert(newContact)
                                    
//                                    viewModel.newContact = newContact
//                                    
//                                    viewModel.saveContact()
                                    
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
