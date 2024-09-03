//
//  ClientCellUIView.swift
//  app874
//
//  Created by Dias Atudinov on 03.09.2024.
//

import SwiftUI

struct ClientCellUIView: View {
    @ObservedObject var viewModel: HomeViewModel
    @State var client: Client
    @State private var progress: Double = 0.0

    var body: some View {
        ZStack {
            Color.mainGreen.opacity(0.1)
            VStack {
                HStack {
                    if let image = client.image {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 52)
                            .clipShape(Circle())
                        
                    } else {
                        Circle()
                            .foregroundColor(.gray.opacity(0.3))
                            .frame(width: 52, height: 52)
                    }
                    
                    VStack {
                        HStack {
                            Text(client.name)
                                .foregroundColor(.black)
                                .font(.system(size: 17, weight: .semibold))
                            Spacer()
                        }
                        HStack {
                            Button {
                                
                            } label: {
                                Text("Edit")
                                    .font(.system(size: 12))
                                    .padding(4).padding(.horizontal)
                                    .foregroundColor(.white)
                                    .background(Color.red)
                                    .cornerRadius(12)
                            }
                            
                            Button {
                                viewModel.deleteClient(for: client)
                            } label: {
                                Text("Delete")
                                    .font(.system(size: 12))
                                    .padding(4).padding(.horizontal)
                                    .foregroundColor(.black)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(Color.mainGreen, lineWidth: 1)
                                    )
                            }
                            Spacer()
                        }
                    }
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "arrow.up")
                            .rotationEffect(Angle(degrees: 45.0))
                            .foregroundColor(Color.mainGreen)
                            .padding(5)
                            .overlay(
                                Circle()
                                    .stroke(Color.mainGreen, lineWidth: 1)
                            )
                    }
                }.padding(.bottom, 10)
                
                VStack(spacing: 10) {
                    HStack {
                        Text("\(client.proceduresPerformed)")
                            .font(.system(size: 17))
                            .foregroundColor(.mainGreen)
                        Spacer()
                        
                        Text("\(client.totalProcedures)")
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
                }.padding(.bottom, 10)
                
                HStack {
                    Text("Income:")
                        .font(.system(size: 16))
                    Spacer()
                    Text(client.income)
                        .font(.system(size: 17, weight: .semibold))
                }
            }.padding(.horizontal)
            
        }.frame(height: 203).cornerRadius(12)
    }
    
    func progressCounter() {
        progress = Double(client.proceduresPerformed)/Double(client.totalProcedures)*100
    
    }
}

#Preview {
    ClientCellUIView(viewModel: HomeViewModel(), client: Client(name: "Dianne Russell", proceduresPerformed: 5, totalProcedures: 12, income: "$500"))
}
