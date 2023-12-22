//
//  ContactPageView.swift
//  businessContacts
//
//  Created by Benia Morgan-Ware on 12/22/23.
//

import SwiftUI

struct ContactPageView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Image(systemName: "person.crop.circle.fill")
                    .font(.system(size: 130))
                    .foregroundColor(.gray)
                    .padding(.top, 30)
                
                Text("Pharaoh Debold")
                    .font(.largeTitle)
                
                Text("Apple")
                    .font(.title2)
                    .fontWeight(.light)
                
                Form {
                    Section {
                        HStack {
                            VStack(alignment: .leading, spacing: 5) {
                            
                                Text("mobile")
                                    .font(.caption2)
                                
                                Text("+ 1 (702) 559-3205")
                                    .listRowSeparator(.hidden)
                                    .foregroundStyle(.blue)
                    
                            }

                        }
 
                    }
                    
                    Section {
                       
                    }
                }
                
                
            }
        }
    }
}

#Preview {
    ContactPageView()
}
