//
//  EditProgressUIView.swift
//  app874
//
//  Created by Dias Atudinov on 03.09.2024.
//

import SwiftUI

struct EditProgressUIView: View {
    @ObservedObject var viewModel: HomeViewModel
    @Binding var isPresented: Bool
    
    @State private var proceduresPerformed = ""
    @State private var proceduresTotal = ""
    @State private var activeTasks = ""
    @State private var income = ""
    @State var progress: Progress
    var body: some View {
        ZStack {
            VStack {
                
                VStack {
                    
                    Rectangle()
                        .frame(width: 36, height: 5)
                        .cornerRadius(2)
                        .opacity(0.5)
                        .padding(.vertical, 5)
                    
                    HStack {
                        Spacer()
                        
                        Button {
                            isPresented = false
                        } label: {
                            ZStack {
                                Circle()
                                    .frame(width: 30, height: 30)
                                    .cornerRadius(12)
                                    .foregroundColor(.gray.opacity(0.3))
                                Image(systemName: "xmark")
                                    .foregroundColor(.black.opacity(0.5))
                                    .font(.system(size: 14, weight: .semibold))
                            }
                        }
                    }
                    
                    HStack {
                        Text("Enter data")
                            .font(.system(size: 20, weight: .semibold))
                        Spacer()
                    }
                    
                    
                    HStack(spacing: 10) {
                        Text("Procedures performed")
                            .frame(width: 175)
                        TextField("5", text: $proceduresPerformed)
                            .keyboardType(.numberPad)
                    }.padding()
                        .background(Color.white).cornerRadius(10)
                    
                    HStack(spacing: 10) {
                        Text("Total procedures")
                        TextField("12", text: $proceduresTotal)
                            .keyboardType(.numberPad)
                    }.padding()
                        .background(Color.white).cornerRadius(10)
                    
                    HStack(spacing: 10) {
                        Text("Active tasks")
                        TextField("107", text: $activeTasks)
                            .keyboardType(.numberPad)
                    }.padding()
                        .background(Color.white).cornerRadius(10)
                    
                    HStack(spacing: 10) {
                        Text("Income")
                        TextField("$500,00", text: $income)
                    }.padding()
                        .background(Color.white).cornerRadius(10)
                    Spacer()
                    Button {
                        if !proceduresPerformed.isEmpty && !proceduresTotal.isEmpty && !activeTasks.isEmpty && !income.isEmpty {
                            let progress = Progress(proceduresPerformed: Int(proceduresPerformed) ?? 0, totalProcedures: Int(proceduresTotal) ?? 0, activeTasks: Int(activeTasks) ?? 0, income: income)
                            
                            viewModel.updateProgress(for: progress)
                            
                            isPresented = false
                            
                        }
                    } label: {
                        HStack {
                            Image(systemName: "checkmark.square.fill")
                            Text("Edit")
                        }.foregroundColor(Color.white)
                            .font(.system(size: 17))
                            .frame(maxWidth: .infinity)
                    }.frame(height: 88).background(Color.red)
                        .cornerRadius(12).padding(.horizontal, -16)
                        
                    
                }.padding(.horizontal)
                .frame(maxWidth: .infinity)
                .background(Color.sheet)
                .cornerRadius(20)
                .onAppear {
                    proceduresPerformed = "\(progress.proceduresPerformed)"
                    proceduresTotal = "\(progress.totalProcedures)"
                    activeTasks = "\(progress.activeTasks)"
                    income = "\(progress.income)"
                }
                
                
                
                    
                
                
            }.edgesIgnoringSafeArea(.bottom)
        }
    }
}

#Preview {
    EditProgressUIView(viewModel: HomeViewModel(), isPresented: .constant(true), progress: Progress(proceduresPerformed: 10, totalProcedures: 20, activeTasks: 10, income: "$1200"))
}
