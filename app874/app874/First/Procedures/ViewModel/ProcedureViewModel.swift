//
//  ProcedureViewModel.swift
//  app874
//
//  Created by Dias Atudinov on 04.09.2024.
//

import Foundation

class ProcedureViewModel: ObservableObject {

    @Published var procedures: [Procedure] = [] {
        didSet {
            saveProcedure()
        }
    }
    
    private let proceduresFileName = "procedures.json"
    
    init() {
        loadProcedure()
    }
    
    func addProcedure(_ procedure: Procedure) {
        procedures.append(procedure)
    }
    
    
    func updateProcedure(for procedure: Procedure, name: String, price: String, time: String, notes: String) {
        
        if let index = procedures.firstIndex(where: { $0.id == procedure.id }) {
            procedures[index].name = name
            procedures[index].price = price
            procedures[index].time = time
            procedures[index].notes = notes
            
        }
    }
    
    func deleteProcedure(for procedure: Procedure) {
        if let index = procedures.firstIndex(where: { $0.id == procedure.id }) {
            procedures.remove(at: index)
        }
    }
    
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    private func proceduresFilePath() -> URL {
        return getDocumentsDirectory().appendingPathComponent(proceduresFileName)
    }
    
    private func saveProcedure() {
        DispatchQueue.global().async {
            let encoder = JSONEncoder()
            do {
                let data = try encoder.encode(self.procedures)
                try data.write(to: self.proceduresFilePath())
            } catch {
                print("Failed to save players: \(error.localizedDescription)")
            }
        }
    }
    
    private func loadProcedure() {
        let decoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: proceduresFilePath())
            procedures = try decoder.decode([Procedure].self, from: data)
        } catch {
            print("Failed to load players: \(error.localizedDescription)")
        }
    }
    
}
