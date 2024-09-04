//
//  ProceduresCellUIView.swift
//  app874
//
//  Created by Dias Atudinov on 04.09.2024.
//

import SwiftUI

struct ProceduresCellUIView: View {
    @ObservedObject var viewModel: ProcedureViewModel
    @State var procedure: Procedure
    @State private var editSheetOpen = false
    @State private var showAlert = false
    var body: some View {
        ZStack {
            Color.mainGreen.opacity(0.1)
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        HStack {
                            HStack(spacing: 3) {
                                Image(systemName: "clock")
                                Text(procedure.time)
                            }.foregroundColor(.white).font(.system(size: 12)).padding(5).padding(.horizontal, 5)
                                .background(Color.mainGreen).cornerRadius(6)
                            
                            Spacer()
                            
                            Menu {
                                Button(action: {
                                    editSheetOpen = true
                                }) {
                                    Label("Edit", systemImage: "pencil")
                                }
                                
                                Button(action: {
                                    showAlert = true
                                }) {
                                    Label("Delete", systemImage: "trash")
                                        .foregroundColor(.red)
                                        
                                }
                            } label: {
                                Image(systemName: "ellipsis.circle")
                                    .foregroundColor(Color.mainGreen)
                                    .font(.system(size: 22))
                            }
                            
                        }
                        
                        VStack(alignment: .leading) {
                            Text(procedure.name)
                                .foregroundColor(.black)
                                .font(.system(size: 17, weight: .semibold))
                            
                            Text(procedure.notes)
                                .foregroundColor(.black.opacity(0.5))
                                .font(.system(size: 13))
                                .frame(height: 54)
                        }
                    }
                    
                    Spacer()
                    
                    
                }.padding(.bottom, 10)
                
                
                
                HStack {
                    Text("Price:")
                        .font(.system(size: 16))
                    Spacer()
                    Text(procedure.price)
                        .font(.system(size: 17, weight: .semibold))
                }
            }.padding()
                .sheet(isPresented: $editSheetOpen) {
                    
                    EditProcedureUIView(viewModel: viewModel, isPresented: $editSheetOpen, procedure: $procedure)
                }
//                .alert(isPresented: $showAlert) {
//                    return Alert(title: Text("Delete"), message: Text("You chose to edit."), dismissButton: .default(Text("OK")))
//                }
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Procedure"),
                        message: Text("The procedure will be permanently removed"),
                        primaryButton: .destructive(Text("Delete")) {
                            viewModel.deleteProcedure(for: procedure)
                        },
                        secondaryButton: .cancel(Text("Cancel"))
                    )
                }
            
        }.frame(height: 183).cornerRadius(14)
        
    }
    
    private func formattedDate(_ date: Date) -> String {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd.MM.yyyy"
            return formatter.string(from: date)
        }
        
        private func formattedTime(_ date: Date) -> String {
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            return formatter.string(from: date)
        }
    
}

#Preview {
    ProceduresCellUIView(viewModel: ProcedureViewModel(), procedure: Procedure(name: "Hair style change", price: "$20", time: "45 min", notes: "dahjdg adgadlhjkgshkjd \nuaid lasdg "))
}
