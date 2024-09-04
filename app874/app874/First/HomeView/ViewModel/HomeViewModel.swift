//
//  HomeViewModel.swift
//  app874
//
//  Created by Dias Atudinov on 03.09.2024.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var progress = Progress(proceduresPerformed: 0, totalProcedures: 0, activeTasks: 0, income: "$0") {
        didSet {
            saveProgress()
        }
    }
    
    @Published var clients: [Client] = [] {
        didSet {
            saveClients()
        }
    }
    
    func updateService(for client: Client, for service: Service, name: String, price: String, date: Date, notes: String) {
        if let index = clients.firstIndex(where: { $0.id == client.id }) {
            
            if service.isExpired {
                if let indexSer = clients[index].story.firstIndex(where: { $0.id == service.id }) {
                    let newService = Service(name: name, price: price, date: date, notes: notes)
                    clients[index].story[indexSer] = newService
                }
            } else {
                if let indexSer = clients[index].services.firstIndex(where: { $0.id == service.id }) {
                    let newService = Service(name: name, price: price, date: date, notes: notes)
                    clients[index].services[indexSer] = newService
                }
            }
                
        }
    }
    
    func addService(for client: Client, name: String, price: String, date: Date, notes: String) {
        if let index = clients.firstIndex(where: { $0.id == client.id }) {
            let service = Service(name: name, price: price, date: date, notes: notes)
            if service.isExpired {
                clients[index].story.append(service)
            } else {
                clients[index].services.append(service)
            }
        }
    }
    
    func checkExpiredServices(for client: Client) {
        let now = Date()
        if let index = clients.firstIndex(where: { $0.id == client.id }) {
            
            clients[index].services = clients[index].services.filter { service in
                if service.date < now {
                    clients[index].story.append(service)
                    return false
                }
                return true
            }
        }
    }
    
    private let clientsFileName = "clients.json"
    private let progressFileName = "progress.json"
    
    init() {
        loadClients()
        loadProgress()
    }
    
    func updateClientPart2(for client: Client, imageData: Data?, name: String, email: String, number: String, note: String) {
        
        if let index = clients.firstIndex(where: { $0.id == client.id }) {
            if let image = imageData {
                clients[index].imageData = image
                clients[index].name = name
                clients[index].email = email
                clients[index].number = number
                clients[index].note = note
            } else {
                clients[index].imageData = nil
                clients[index].name = name
                clients[index].email = email
                clients[index].number = number
                clients[index].note = note
            }
            
        }
    }
    
    func updateClient(for client: Client) {
        print("1")
        
        if let index = clients.firstIndex(where: { $0.id == client.id }) {
            print("2")
            clients[index] = client
            
        }
    }
    
    func updateProgress(for progress: Progress) {
        self.progress = progress
    }
    
    func addClient(for client: Client) {
        clients.append(client)
    }
    
    func deleteClient(for client: Client) {
        if let index = clients.firstIndex(where: { $0.id == client.id }) {
            clients.remove(at: index)
        }
    }
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    private func clientsFilePath() -> URL {
        return getDocumentsDirectory().appendingPathComponent(clientsFileName)
    }
    
    private func progressFilePath() -> URL {
        return getDocumentsDirectory().appendingPathComponent(progressFileName)
    }
    
    private func saveClients() {
        DispatchQueue.global().async {
            let encoder = JSONEncoder()
            do {
                let data = try encoder.encode(self.clients)
                try data.write(to: self.clientsFilePath())
            } catch {
                print("Failed to save players: \(error.localizedDescription)")
            }
        }
    }
    
    private func saveProgress() {
        DispatchQueue.global().async {
            let encoder = JSONEncoder()
            do {
                let data = try encoder.encode(self.progress)
                try data.write(to: self.progressFilePath())
            } catch {
                print("Failed to save players: \(error.localizedDescription)")
            }
        }
    }
    
    private func loadClients() {
        let decoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: clientsFilePath())
            clients = try decoder.decode([Client].self, from: data)
        } catch {
            print("Failed to load players: \(error.localizedDescription)")
        }
    }
    
    private func loadProgress() {
        let decoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: progressFilePath())
            progress = try decoder.decode(Progress.self, from: data)
        } catch {
            print("Failed to load players: \(error.localizedDescription)")
        }
    }
}
