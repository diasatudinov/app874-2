//
//  Client.swift
//  app874
//
//  Created by Dias Atudinov on 03.09.2024.
//

import SwiftUI

struct Client: Identifiable, Hashable, Codable {
    var id = UUID()
    var imageData: Data?
    var name: String
    var proceduresPerformed: Int
    var totalProcedures: Int
    var income: String
    
    enum CodingKeys: String, CodingKey {
        case id, imageData, name, proceduresPerformed, totalProcedures, income
    }
    
    var image: UIImage? {
        get {
            guard let data = imageData else { return nil }
            return UIImage(data: data)
        }
        set {
            imageData = newValue?.jpegData(compressionQuality: 1.0)
        }
    }
   
}
