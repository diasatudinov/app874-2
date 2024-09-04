//
//  HomeUIView.swift
//  app874
//
//  Created by Dias Atudinov on 03.09.2024.
//

import SwiftUI

struct HomeUIView: View {
    @ObservedObject var viewModel: HomeViewModel
    @State private var progress: Double = 0.0
    @State private var isSheetPresented = false
    @State private var isEditSheetPresented = false
    @State private var isEditClientSheetPresented = false

    
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text("Your progress")
                        .font(.system(size: 34, weight: .bold))
                    Spacer()
                }
                
                ZStack {
                    Rectangle()
                        .foregroundColor(.white)
                        .cornerRadius(16)
                        .shadow(radius: 8).opacity(0.4)
                    
                    VStack(spacing: 15) {
                        HStack {
                            
                            Spacer()
                            Button {
                                isEditSheetPresented = true
                            } label: {
                                Image(systemName: "square.and.pencil")
                                    .foregroundColor(.black.opacity(0.4))
                            }
                            
                        }.padding(.top).padding(.horizontal)
                        
                        VStack(spacing: 10) {
                            HStack {
                                Text("\(viewModel.progress.proceduresPerformed)")
                                    .font(.system(size: 17))
                                    .foregroundColor(.mainGreen)
                                Spacer()
                                
                                Text("\(viewModel.progress.totalProcedures)")
                                    .font(.system(size: 17))
                                    .foregroundColor(.black.opacity(0.4))
                            }
                            
                            ProgressView(value: progress, total: 100)
                                .progressViewStyle(LinearProgressViewStyle())
                                .accentColor(.mainGreen)
                                .cornerRadius(15)
                                .scaleEffect(y: 2.5, anchor: .center)
                                .onAppear {
                                    progressCounter()
                                }
                            
                            HStack {
                                Text("Procedures performed")
                                    .font(.system(size: 13))
                                Spacer()
                                
                                Text("Total procedures")
                                    .font(.system(size: 13))
                                    
                            }.foregroundColor(.black.opacity(0.4))
                        }.padding(.horizontal)
                        
                        HStack {
                            VStack {
                                Text("Active tasks")
                                    .font(.system(size: 20, weight: .semibold))
                                Text("\(viewModel.progress.activeTasks)")
                                    .font(.system(size: 28, weight: .bold))
                                    .foregroundColor(.mainGreen)
                            }
                            .padding().padding(.horizontal,8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color.mainGreen, lineWidth: 1)
                            )
                            //Spacer()
                            VStack {
                                Text("Income")
                                    .font(.system(size: 20, weight: .semibold))
                                Text("\(viewModel.progress.income)")
                                    .font(.system(size: 28, weight: .bold))
                                    .foregroundColor(.mainGreen)
                                    .frame(width: 129)
                            }
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color.mainGreen, lineWidth: 1)
                            )
                        }.padding(.horizontal)
                        
                        Spacer()
                    }
                        
                }.frame(height: 249)
                
                HStack {
                    Text("Сlients")
                        .font(.system(size: 28, weight: .bold))
                    Spacer()
                    if !viewModel.clients.isEmpty {
                        Button {
                            isSheetPresented.toggle()
                        } label: {
                            Image(systemName: "plus")
                                .font(.system(size: 24))
                                .foregroundColor(.black)
                            
                        }
                    }
                }
                if viewModel.clients.isEmpty {
                    VStack(spacing: 10) {
                        Spacer()
                        Text("The list is empty")
                            .font(.system(size: 20, weight: .semibold))
                        Text("Add your clients and start \ntracking your progress now")
                            .multilineTextAlignment(.center)
                            .foregroundColor(.black.opacity(0.3))
                            .padding(.bottom, 10)
                        
                        Button {
                            isSheetPresented.toggle()
                        } label: {
                            HStack {
                                Image(systemName: "plus.app.fill")
                                Text("Add clients")
                            }.padding(10).padding(.vertical, 5).foregroundColor(.white).background(Color.mainGreen).cornerRadius(12)
                        }
                        Spacer()
                        Spacer()
                    }
                } else {
                    ScrollView {
                        ForEach($viewModel.clients, id: \.self) { $client in
                            ClientCellUIView(viewModel: viewModel, client: $client, isEditClientSheetPresented: $isEditClientSheetPresented)
                                 
                            
                        }
                    }
                }
                
                
            }.padding(.horizontal).disabled(isSheetPresented)
                .sheet(isPresented: $isSheetPresented) {
                    AddClientSheetView(viewModel: viewModel, isPresented: $isSheetPresented)
                }
            
                .sheet(isPresented: $isEditSheetPresented) {
                    EditProgressUIView(viewModel: viewModel, isPresented: $isEditSheetPresented, progress: viewModel.progress)
                }
            
                
                
            
//            if isSheetPresented {
//                ZStack {
//                    AddClientSheetView(viewModel: viewModel, isPresented: $isSheetPresented)
//                        
//                        
//                    
//                }.transition(.move(edge: .bottom)).animation(.easeInOut)
//            }
        }
        
    }
    
    func progressCounter() {
        progress = Double(viewModel.progress.proceduresPerformed)/Double(viewModel.progress.totalProcedures)*100
    
    }
}

#Preview {
    HomeUIView(viewModel: HomeViewModel())
}
