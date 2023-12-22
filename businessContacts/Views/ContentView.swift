//
//  ContentView.swift
//  businessContacts
//
//  Created by Benia Morgan-Ware on 8/25/23.
//

import SwiftUI
import SwiftData


struct ContentView: View {
    
    @Environment(\.modelContext) var context
    @Query(sort: \Contact.name) var contacts: [Contact]
    
    @State var addContactSheetShowing = false
    @State private var contactToEdit: Contact?
    @State private var searchText = ""
    
    var searchResults: [Contact] {
        if searchText.isEmpty {
            return contacts
        } else {
            return contacts.filter { contact in
                let nameMatch = contact.name?.lowercased().contains(searchText.lowercased()) ?? false
                let companyMatch = contact.company?.lowercased().contains(searchText.lowercased()) ?? false
                return nameMatch || companyMatch
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(searchResults) { contact in
                        NavigationLink(value: contact) {
                        ContactCellView(contact: contact)
                        }
                            
                    }
                    .onDelete { indexSet in
                        for index in indexSet {
                            context.delete(contacts[index])
                        }
                        
                    }
                    
                }
                .listStyle(.plain)
                .listSectionSeparator(Visibility.hidden)
                .navigationDestination(for: Contact.self) { contact in
                    ContactPageView(contact: contact)
                }
                .navigationTitle("Business Contacts")
                .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
                .sheet(isPresented: $addContactSheetShowing) { AddNewContact() }
                .sheet(item: $contactToEdit) { contact in
                    UpdateContactView(contact: contact)
                }
                .toolbar {
                    if !contacts.isEmpty {
                        Button("Add Contact", systemImage: "plus") {
                            addContactSheetShowing.toggle()
                        }
                        
                    }
                    
                }
                .overlay {
                    if contacts.isEmpty {
                        ContentUnavailableView(label: {
                            Label("No Contacts to Display", systemImage: "person.fill.questionmark")
                        }, description: {
                            Text("Add a new contact to see your list")
                        }, actions: {
                            Button("Add New Contact") {
                                addContactSheetShowing.toggle()
                            }
                        })
                        .offset(y: -60)
                    }
                    if searchResults.isEmpty && !contacts.isEmpty {
                        ContentUnavailableView.search
                            .offset(y: -40)
                    }
                }
                //additional content to show number of contacts stored
                if !contacts.isEmpty && !searchResults.isEmpty {
                    Text("\(contacts.count) Contacts")
                        .bold()
                    
                    Spacer()
                }
                
            }
            
        }
        
        
    }
}

#Preview {
    let preview = previewContainer([Contact.self])
    return ContentView().modelContainer(preview.container)
}
