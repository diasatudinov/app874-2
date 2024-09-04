//
//  AddProcedureUIView.swift
//  app874
//
//  Created by Dias Atudinov on 04.09.2024.
//

import SwiftUI

struct AddProcedureUIView: View {
    @ObservedObject var viewModel: ProcedureViewModel
    @Binding var isPresented: Bool
    
    @State private var name = ""
    @State private var price = ""
    @State private var time = ""
    @State private var note = ""
    
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
                        Text("Create procedure")
                            .font(.system(size: 20, weight: .semibold))
                        Spacer()
                    }
                    
                    
                    HStack(spacing: 10) {
                        Text("Name")
                        TextField("Classic haircut", text: $name)
                    }.padding()
                        .background(Color.white).cornerRadius(10)
                    
                    HStack(spacing: 10) {
                        Text("Price")
                        TextField("$30,00", text: $price)
                    }.padding()
                        .background(Color.white).cornerRadius(10)
                    
                    HStack(spacing: 10) {
                        Text("Time")
                        TextField("45 min", text: $time)
                    }.padding()
                        .background(Color.white).cornerRadius(10)
                    
                    HStack {
                        Text("Note")
                            .font(.system(size: 13))
                        Spacer()
                    }
                    VStack() {
                        
                            TextEditor(text: $note)
                                //.multilineTextAlignment(.leading)
                            .cornerRadius(16)
                            
                            .frame(maxWidth: .infinity)
                    }.frame(height: 143).frame(maxWidth: .infinity).overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.mainGreen, lineWidth: 1)
                    ).padding(.bottom, 15)
                    Spacer()
                    Button {
                        if !name.isEmpty && !time.isEmpty && !price.isEmpty && !note.isEmpty {
                            
                            let procedure = Procedure(name: name, price: price, time: time, notes: note)
                            viewModel.addProcedure(procedure)
                            
                            isPresented = false
                        }
                    } label: {
                        HStack {
                            Image(systemName: "checkmark.square.fill")
                            Text("Add")
                        }.foregroundColor(Color.white)
                            .font(.system(size: 17))
                            .frame(maxWidth: .infinity)
                    }.frame(height: 88).background(!name.isEmpty && !time.isEmpty && !price.isEmpty && !note.isEmpty ? Color.red : Color.red.opacity(0.5) )
                        .cornerRadius(12).padding(.horizontal, -16)
                        
                    
                }.padding(.horizontal)
                .frame(maxWidth: .infinity)
                .background(Color.sheet)
                .cornerRadius(20)
            }.edgesIgnoringSafeArea(.bottom)
            
            
            
            
            
            
        }
    }
}

#Preview {
    AddProcedureUIView(viewModel: ProcedureViewModel(), isPresented: .constant(true))
}

#Preview {
    EditProcedureUIView(viewModel: ProcedureViewModel(), isPresented: .constant(true), procedure: .constant(Procedure(name: "DIAS1", price: "$200", time: "40 min", notes: "sada loooong text")))
}

struct EditProcedureUIView: View {
    @ObservedObject var viewModel: ProcedureViewModel
    @Binding var isPresented: Bool
    @Binding var procedure: Procedure
    
    @State private var name = ""
    @State private var price = ""
    @State private var time = ""
    @State private var note = ""
    
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
                        Text("Edit procedure")
                            .font(.system(size: 20, weight: .semibold))
                        Spacer()
                    }
                    
                    
                    HStack(spacing: 10) {
                        Text("Name")
                        TextField("Classic haircut", text: $name)
                    }.padding()
                        .background(Color.white).cornerRadius(10)
                    
                    HStack(spacing: 10) {
                        Text("Price")
                        TextField("$30,00", text: $price)
                    }.padding()
                        .background(Color.white).cornerRadius(10)
                    
                    HStack(spacing: 10) {
                        Text("Time")
                        TextField("45 min", text: $time)
                    }.padding()
                        .background(Color.white).cornerRadius(10)
                    
                    HStack {
                        Text("Note")
                            .font(.system(size: 13))
                        Spacer()
                    }
                    VStack() {
                        
                            TextEditor(text: $note)
                                //.multilineTextAlignment(.leading)
                            .cornerRadius(16)
                            
                            .frame(maxWidth: .infinity)
                    }.frame(height: 143).frame(maxWidth: .infinity).overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.mainGreen, lineWidth: 1)
                    ).padding(.bottom, 15)
                    Spacer()
                    Button {
                        
                        viewModel.updateProcedure(for: procedure, name: name, price: price, time: time, notes: note)
                        
                        isPresented = false
                        
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
                    
                    name = procedure.name
                    price = procedure.price
                    time = procedure.time
                    note = procedure.notes
                    
                }
            }.edgesIgnoringSafeArea(.bottom)
            
            
            
            
            
            
        }
    }
}
