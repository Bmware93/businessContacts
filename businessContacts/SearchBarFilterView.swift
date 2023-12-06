//
//  SearchBarFilterView.swift
//  businessContacts
//
//  Created by Benia Morgan-Ware on 12/6/23.
//

import SwiftUI

//Not related to the app. Used this page to practice using swift search bar
struct SearchBarFilterView: View {
    var contacts = ["Nick", "Tom", "Mallory", "Telayne", "Lexi"]
    @State private var searchText = ""
    
    var searchResults: [String] {
        if searchText.isEmpty {
            return contacts
        } else {
            return contacts.filter{ $0.contains(searchText)}
        }
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(searchResults, id: \.self) { contact in
                    NavigationLink {
                        Text(contact)
                    } label: {
                        Text(contact)
                    }
                }
                
            }
            .navigationTitle("Contacts")
        }
        .searchable(text: $searchText, prompt: "Search")
    }
}

#Preview {
    SearchBarFilterView()
}
