//
//  Procedure.swift
//  app874
//
//  Created by Dias Atudinov on 04.09.2024.
//

import Foundation

struct Procedure: Identifiable, Hashable, Codable {
    var id = UUID()
    var name: String
    var price: String
    var time: String
    var notes: String
    
}
