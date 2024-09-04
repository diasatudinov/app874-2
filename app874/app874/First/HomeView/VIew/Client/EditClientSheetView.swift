//
//  EditClientSheetView.swift
//  app874
//
//  Created by Dias Atudinov on 03.09.2024.
//

import SwiftUI

struct EditClientSheetView: View {
    @ObservedObject var viewModel: HomeViewModel
    @State private var isShowingImagePicker = false
    @State private var selectedImage: UIImage?
    @Binding var isPresented: Bool
    
    @State private var name = ""
    @State private var proceduresPerformed = ""
    @State private var proceduresTotal = ""
    @State private var income = ""
    
    @Binding var client: Client
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
                        Text("Edit the information")
                            .font(.system(size: 20, weight: .semibold))
                        Spacer()
                    }
                    
                    if let image = selectedImage {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 99)
                            .clipShape(Circle())
                        
                    } else {
                        Circle()
                            .foregroundColor(.gray.opacity(0.3))
                            .frame(width: 99, height: 99)
                    }
                    Text("Pick a picture")
                        .foregroundColor(.red)
                        .onTapGesture {
                            isShowingImagePicker = true
                        }
                    
                    HStack(spacing: 10) {
                        Text("Name")
                        TextField("Dianne Russell", text: $name)
                    }.padding()
                        .background(Color.white).cornerRadius(10)
                    
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
                        Text("Income")
                        TextField("$500,00", text: $income)
                    }.padding()
                        .background(Color.white).cornerRadius(10)
                    Spacer()
                    Button {
                        if !name.isEmpty && !proceduresPerformed.isEmpty && !proceduresTotal.isEmpty && !income.isEmpty {
                            if let image = selectedImage {
                                client = Client(imageData: image.jpegData(compressionQuality: 1.0) ,name: name, proceduresPerformed: Int(proceduresPerformed) ?? 0, totalProcedures: Int(proceduresTotal) ?? 0, income: income, email: "", number: "", note: "")
                                viewModel.updateClient(for: client)
                            } else {
                                client = Client(name: name, proceduresPerformed: Int(proceduresPerformed) ?? 0, totalProcedures: Int(proceduresTotal) ?? 0, income: income, email: "", number: "", note: "")
                                viewModel.updateClient(for: client)
                            }
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
                .sheet(isPresented: $isShowingImagePicker, onDismiss: loadImage) {
                    ImagePicker(selectedImage: $selectedImage, isPresented: $isShowingImagePicker)
                }
                .onAppear {
                    if let image = client.image {
                        selectedImage = image
                        name = client.name
                        proceduresPerformed = "\(client.proceduresPerformed)"
                        proceduresTotal = "\(client.totalProcedures)"
                        income = client.income
                    } else {
                        name = client.name
                        proceduresPerformed = "\(client.proceduresPerformed)"
                        proceduresTotal = "\(client.totalProcedures)"
                        income = client.income
                    }
                }
                
                    
                
                
            }.edgesIgnoringSafeArea(.bottom)
            
            
            
            
            
            
        }
    }
    func loadImage() {
        if let selectedImage = selectedImage {
            print("Selected image size: \(selectedImage.size)")
        }
    }
}


#Preview {
    EditClientSheetView(viewModel: HomeViewModel(), isPresented: .constant(true), client: .constant(Client(name: "DIAS ATUDINOV", proceduresPerformed: 100, totalProcedures: 200, income: "$1200", email: "", number: "", note: "")))
}
