//
//  businessContactsApp.swift
//  businessContacts
//
//  Created by Benia Morgan-Ware on 8/25/23.
//

import SwiftUI
import SwiftData

@main
struct businessContactsApp: App {
    var body: some Scene {
        WindowGroup {
           ContentView()
        }
        .modelContainer(for: [Contact.self])
    }
}
