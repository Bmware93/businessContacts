//
//  ContentView.swift
//  businessContacts
//
//  Created by Benia Morgan-Ware on 8/25/23.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    //@StateObject private var vm = ContactViewModel()
    @State var addContactSheetShowing = false
    @Environment(\.modelContext) var context
    @Query(sort: \Contact.name) var contacts: [Contact]
    
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(contacts) { contact in
                    ContactView(contact: contact)
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
            .sheet(isPresented: $addContactSheetShowing) { AddNewContact() }
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
            }
            
        }
        //.environmentObject(vm)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
