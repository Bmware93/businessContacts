//
//  ContactView.swift
//  businessContacts
//
//  Created by Benia Morgan-Ware on 8/25/23.
//

import SwiftUI
import SwiftData

struct ContactView: View {
    @Environment(\.modelContext) var context
    
    let contact: Contact
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text("**Name:** \(contact.name)")
            Text("**Email:** \(contact.email)")
            Divider()
            Text("**Company:** \(contact.company)")
        
        }
        .frame(maxWidth: .infinity,
               alignment: .leading)
        .padding()
        .background(Color.gray.opacity(0.1), in: RoundedRectangle(cornerRadius: 10, style: .continuous))
        .padding(.horizontal, 4)
    }
}

#Preview {
    ContactView(contact: Contact(name: "Benia Morgan", email: "bmorganware@gmail.com", company: "Apple"))
}
