//
//  ContactModels.swift
//  businessContacts
//
//  Created by Benia Morgan-Ware on 8/26/23.
//

import Foundation
import SwiftData

@Model
//Because this project is being syncing SwiftData to CloudKit it requires that
//All properties must either have default values or be marked as optional, alongside their initializer.
//I have done this below to ensure that the data model will sync to icloud
//The requirement here is that the properties must either have default values or be marked as optional in the initializer.

class Contact: Identifiable {
    var name: String?
    var email: String?
    var company: String?
    
    init(name: String?, email: String?, company: String?) {
        self.name = name
        self.email = email
        self.company = company
    }
}


