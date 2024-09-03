//
//  HomeViewModel.swift
//  app874
//
//  Created by Dias Atudinov on 03.09.2024.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var progress = Progress(proceduresPerformed: 45, totalProcedures: 152, activeTasks: 0, income: "$0")
    @Published var clients: [Client] = [Client(name: "Dianne Russell", proceduresPerformed: 5, totalProcedures: 12, income: "$500"),
                                        Client(name: "Dianne Russell", proceduresPerformed: 5, totalProcedures: 12, income: "$500"),
                                        Client(name: "Dianne Russell", proceduresPerformed: 5, totalProcedures: 12, income: "$500")]
    
    
    func addClient(for client: Client) {
        clients.append(client)
    }
    
    func deleteClient(for client: Client) {
        if let index = clients.firstIndex(where: { $0.id == client.id }) {
            clients.remove(at: index)
        }
    }
}
