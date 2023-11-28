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
            ZStack {
                if vm.contacts.isEmpty {
    
                        Text("No Contacts to display")
                            .foregroundColor(.secondary)
                } else {
                    
                    List {
                        ForEach(vm.contacts, id: \.self){ contact in
                           ContactView(contact: contact)
                            }
                                                         
                    }
                    .listStyle(.plain)
                    .listSectionSeparator(Visibility.hidden)
                }
            }
            .navigationTitle("Business Contacts")
            .toolbar {
                Button {
                    addContactSheetShowing.toggle()
                } label: {
                    Image(systemName: "plus")
                }
                .sheet(isPresented: $addContactSheetShowing) {
                    AddNewContact()
                        .environmentObject(vm)
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
