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
                            }
                            .padding().padding(.horizontal,27)
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
                        ForEach(viewModel.clients, id: \.self) { client in
                            ClientCellUIView(viewModel: viewModel, client: client)
                            
                        }
                    }
                }
                
                Spacer()
                
            }.padding(.horizontal).disabled(isSheetPresented)
            if isSheetPresented {
                ZStack {
                    AddClientSheetView(viewModel: viewModel, isPresented: $isSheetPresented)
                        
                        
                    
                }.transition(.move(edge: .bottom)).animation(.easeInOut)
            }
        }
        
    }
    
    func progressCounter() {
        progress = Double(viewModel.progress.proceduresPerformed)/Double(viewModel.progress.totalProcedures)*100
    
    }
}

#Preview {
    HomeUIView(viewModel: HomeViewModel())
}


struct AddClientSheetView: View {
    @ObservedObject var viewModel: HomeViewModel
    @State private var isShowingImagePicker = false
    @State private var selectedImage: UIImage?
    @Binding var isPresented: Bool
    
    @State private var name = ""
    @State private var proceduresPerformed = ""
    @State private var proceduresTotal = ""
    @State private var income = ""
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                
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
                        Text("Add client")
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
                                let client = Client(imageData: image.jpegData(compressionQuality: 1.0) ,name: name, proceduresPerformed: Int(proceduresPerformed) ?? 0, totalProcedures: Int(proceduresTotal) ?? 0, income: income)
                                viewModel.addClient(for: client)
                            } else {
                                let client = Client(name: name, proceduresPerformed: Int(proceduresPerformed) ?? 0, totalProcedures: Int(proceduresTotal) ?? 0, income: income)
                                viewModel.addClient(for: client)
                            }
                            isPresented = false
                            name=""
                            proceduresPerformed=""
                            proceduresTotal=""
                            income=""
                        }
                    } label: {
                        HStack {
                            Image(systemName: "checkmark.square.fill")
                            Text("Add")
                        }.foregroundColor(Color.white)
                            .font(.system(size: 17))
                            .frame(maxWidth: .infinity)
                    }.frame(height: 88).background(Color.red)
                        .cornerRadius(12).padding(.horizontal, -16)
                        
                    
                }.padding(.horizontal)
                .frame(maxWidth: .infinity)
                .background(Color.sheet)
                .frame(height: isPresented ? UIScreen.main.bounds.height / 1.5 : 0)
                .cornerRadius(20)
                .sheet(isPresented: $isShowingImagePicker, onDismiss: loadImage) {
                    ImagePicker(selectedImage: $selectedImage, isPresented: $isShowingImagePicker)
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
