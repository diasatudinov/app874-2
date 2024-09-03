//
//  Progress.swift
//  app874
//
//  Created by Dias Atudinov on 03.09.2024.
//

import Foundation

struct Progress: Identifiable, Hashable, Codable {
    let id = UUID()
    var proceduresPerformed: Int
    var totalProcedures: Int
    var activeTasks: Int
    var income: String
   
}
