//
//  ContactModels.swift
//  businessContacts
//
//  Created by Benia Morgan-Ware on 8/26/23.
//

import Foundation
import SwiftData

@Model
class Contact: Identifiable {
    var name: String
    var email: String
    var company: String
    
    init(name: String, email: String, company: String) {
        self.name = name
        self.email = email
        self.company = company
    }
}


