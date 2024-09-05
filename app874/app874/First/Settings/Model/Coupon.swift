//
//  Coupon.swift
//  app874
//
//  Created by Dias Atudinov on 05.09.2024.
//

import Foundation

struct Coupon: Identifiable, Hashable, Codable {
    var id = UUID()
    var name: String
    var discount: String
    var clients: [Client]
    var notes: String
    
}
