//
//  previewContainer.swift
//  businessContacts
//
//  Created by Benia Morgan-Ware on 12/20/23.
//

import Foundation
import SwiftData

//Special container setup specifically for previews
//Previews often crash when using swiftUI previews with Swift Data

struct previewContainer {
    let container: ModelContainer!
    
    init(_ types: [any PersistentModel.Type],
         isStoredInMemoryOnly: Bool = true) {
        
        
        let schema = Schema(types)
        let config = ModelConfiguration(isStoredInMemoryOnly: isStoredInMemoryOnly)
        self.container = try! ModelContainer(for: schema, configurations: config)
    }
    
}
