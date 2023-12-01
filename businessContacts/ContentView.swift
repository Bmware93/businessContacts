//
//  ContentView.swift
//  businessContacts
//
//  Created by Benia Morgan-Ware on 8/25/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var vm = ContactViewModel()
    @State var addContactSheetShowing = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(vm.contacts, id: \.self){ contact in
                    ContactView(contact: contact)
                }
                
            }
            .listStyle(.plain)
            .listSectionSeparator(Visibility.hidden)
            .navigationTitle("Business Contacts")
            .toolbar {
                Button("Add Contact", systemImage: "plus") {
                    addContactSheetShowing.toggle()
                }
                .sheet(isPresented: $addContactSheetShowing) {
                    AddNewContact()
                       // .environmentObject(vm)
                }
                
            }
            .overlay {
                if vm.contacts.isEmpty {
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
        .environmentObject(vm)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
