//
//  ProceduresUIView.swift
//  app874
//
//  Created by Dias Atudinov on 04.09.2024.
//

import SwiftUI

struct ProceduresUIView: View {
    @ObservedObject var viewModel: ProcedureViewModel
    @State private var addSheetShow = false
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text("All procedures")
                        .font(.system(size: 34, weight: .bold))
                        .foregroundColor(.black)
                    Spacer()
                    
                    if !viewModel.procedures.isEmpty {
                        Button {
                            addSheetShow = true
                        } label: {
                            Image(systemName: "plus")
                                .font(.system(size: 26))
                                .foregroundColor(.black)
                        }
                    }
                }
                if viewModel.procedures.isEmpty {
                    
                    VStack(spacing: 0) {
                        Text("The list is empty")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.black)
                        Text("Create new services for your customers now")
                            .multilineTextAlignment(.center)
                            .font(.system(size: 20))
                            .foregroundColor(.black.opacity(0.3))
                            .frame(width: 210)
                            .padding(10)
                            .padding(.bottom)
                        
                        Button {
                            addSheetShow = true
                        } label : {
                            HStack {
                                Image(systemName: "plus.app.fill")
                                Text("Add procedure")
                            }.foregroundColor(.white).padding(10).padding(.vertical,5).background(Color.mainGreen).cornerRadius(12)
                        }
                    }.padding(.top, 50)
                    
                } else {
                    
                    ScrollView {
                        ForEach(viewModel.procedures, id: \.self) { procedure in
                         ProceduresCellUIView(viewModel: viewModel, procedure: procedure)
                            
                        }
                    }
                    
                }
                
                Spacer()
            }.padding(.horizontal)
                .sheet(isPresented: $addSheetShow){
                    AddProcedureUIView(viewModel: viewModel, isPresented: $addSheetShow)
                }
        }
    }
}

#Preview {
    ProceduresUIView(viewModel: ProcedureViewModel())
}
