//
//  AddClientSheetView.swift
//  app874
//
//  Created by Dias Atudinov on 03.09.2024.
//

import SwiftUI

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
                                let client = Client(imageData: image.jpegData(compressionQuality: 1.0) ,name: name, proceduresPerformed: Int(proceduresPerformed) ?? 0, totalProcedures: Int(proceduresTotal) ?? 0, income: income, email: "", number: "", note: "")
                                viewModel.addClient(for: client)
                            } else {
                                let client = Client(name: name, proceduresPerformed: Int(proceduresPerformed) ?? 0, totalProcedures: Int(proceduresTotal) ?? 0, income: income, email: "", number: "", note: "")
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

#Preview {
    AddClientSheetView(viewModel: HomeViewModel(), isPresented: .constant(true))
}

struct EditSheetClientView: View {
    @ObservedObject var viewModel: HomeViewModel
    @State private var isShowingImagePicker = false
    @State private var selectedImage: UIImage?
    @Binding var isPresented: Bool
    @Binding var client: Client
    
    @State private var name = ""
    @State private var email = ""
    @State private var phone = ""
    @State private var notes = ""
    
    
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
                        Text("Edit profile")
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
                        Text("Email")
                        TextField("EleanorPena example.com", text: $email)
                    }.padding()
                        .background(Color.white).cornerRadius(10)
                    
                    HStack(spacing: 10) {
                        Text("Phone")
                        TextField("(603) 555-0123", text: $phone)
                    }.padding()
                        .background(Color.white).cornerRadius(10)
                    
                    HStack {
                        Text("Note")
                            .font(.system(size: 13))
                        Spacer()
                    }.padding(.top, 10)
                    VStack() {
                        
                            TextEditor(text: $notes)
                                //.multilineTextAlignment(.leading)
                            .cornerRadius(16)
                            
                        .frame(maxWidth: .infinity)
                    }.frame(maxWidth: .infinity).overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.mainGreen, lineWidth: 1)
                    ).padding(.bottom, 15)
                    
                    Spacer()
                    Button {
                        viewModel.updateClientPart2(for: client, imageData: selectedImage?.jpegData(compressionQuality: 1.0), name: name, email: email, number: phone, note: notes)
                        
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
                .sheet(isPresented: $isShowingImagePicker, onDismiss: loadImage) {
                    ImagePicker(selectedImage: $selectedImage, isPresented: $isShowingImagePicker)
                }
                .onAppear {
                    selectedImage = client.image
                    name = client.name
                    email = client.email
                    phone = client.number
                    notes = client.note
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
    EditSheetClientView(viewModel: HomeViewModel(), isPresented: .constant(true), client: .constant(Client(name: "AAAA", proceduresPerformed: 12, totalProcedures: 24, income: "$123", email: "sadasds@mail.com", number: "9089080", note: "wash hair good to usse sdasda")))
    
}
