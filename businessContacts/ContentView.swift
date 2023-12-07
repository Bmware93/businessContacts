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
                let nameMatch = contact.name?.localizedCaseInsensitiveContains(searchText) ?? false
                let companyMatch = contact.company?.localizedCaseInsensitiveContains(searchText) ?? false
                return nameMatch || companyMatch
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(searchResults) { contact in
                        ContactView(contact: contact)
                            .onTapGesture {
                                contactToEdit = contact
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
                .navigationTitle("Business Contacts")
                .searchable(text: $searchText)
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
