//
//  ContactPageView.swift
//  businessContacts
//
//  Created by Benia Morgan-Ware on 12/22/23.
//

import SwiftUI
import SwiftData

struct ContactPageView: View {
    @Environment(\.modelContext) var context
    
    
    @Environment(\.dismiss) private var dismiss
    @Bindable var contact: Contact
    @State private var contactToEdit: Contact?

    
    var body: some View {
  
            VStack {
                if contact.contactImageData != nil {
                    let uiImage = UIImage(data: contact.contactImageData!)
                    Image(uiImage: uiImage!)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 300)
                } else {
                    
                    Image(systemName: "person.crop.circle.fill")
                        .font(.system(size: 130))
                        .foregroundColor(.gray)
                        .padding(.top, 30)
                }
                
                Text(contact.name ?? "")
                    .font(.largeTitle)
                
                Text(contact.company ?? "")
                    .font(.title2)
                    .fontWeight(.light)
                
                Form {
                    Section {
                        HStack {
                            VStack(alignment: .leading, spacing: 5) {
                                
                                Text("mobile")
                                    .font(.caption2)
                                
                                Text("+ 1 (702) 559-3205")
                                    .listRowSeparator(.hidden)
                                    .foregroundStyle(.blue)
                            }
                            
                        }
                        
                    }
                    
                    Section {
                        HStack {
                            VStack(alignment: .leading, spacing: 5) {
                                Text("email")
                                    .font(.caption2)
                                
                                Text(contact.email ?? "")
                            }
                            
                        }
                        
                    }
                    
                    
                }
            }
            .sheet(item: $contactToEdit) { contact in
                UpdateContactView(contact: contact)
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Edit") {
                        contactToEdit = contact
                    }
                }
            }
        }
    }

#Preview {
    let preview = previewContainer([Contact.self])
    return ContactPageView(contact: Contact(name: "Pharaoh Debold", email: "pdebold19@gmail.com", company: "Apple", contactImageData: nil)).modelContainer(preview.container)
}
