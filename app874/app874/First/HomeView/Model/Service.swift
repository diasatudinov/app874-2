//
//  Service.swift
//  app874
//
//  Created by Dias Atudinov on 04.09.2024.
//

import Foundation

struct Service: Identifiable, Hashable, Codable {
    var id = UUID()
    var name: String
    var price: String
    var date: Date
    var notes: String
    
    var isExpired: Bool {
        date < Date()
    }
   
   
}
