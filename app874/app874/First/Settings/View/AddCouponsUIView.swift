//
//  AddCouponsUIView.swift
//  app874
//
//  Created by Dias Atudinov on 05.09.2024.
//

import SwiftUI

struct AddCouponsUIView: View {
    @ObservedObject var viewModel: SettingsViewModel
    @ObservedObject var homeVM: HomeViewModel
    @Binding var isPresented: Bool
    
    @State private var name = ""
    @State private var discount = ""
    @State private var note = ""
    
    @State private var selectedParticipants: [Client] = []
    
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
                        Text("Create coupon")
                            .font(.system(size: 20, weight: .semibold))
                        Spacer()
                    }
                    
                    
                    HStack(spacing: 10) {
                        Text("Name")
                        TextField("Discount on your first haircut", text: $name)
                    }.padding()
                        .background(Color.white).cornerRadius(10)
                    
                    HStack(spacing: 10) {
                        Text("Discount")
                        TextField("Get 20% off your first haircut at our salon!", text: $discount)
                    }.padding()
                        .background(Color.white).cornerRadius(10)
                     
                    HStack(spacing: 10) {
                        Text("Clients")
                        Text("\(selectedParticipants.count)")
                            .foregroundColor(.black.opacity(0.23))
                        Spacer()
                        Menu {
                            // Перебираем всех участников и создаем элементы меню
                            ForEach(homeVM.clients, id: \.self) { participant in
                                Button(action: {
                                    toggleSelection(for: participant)
                                }) {
                                    HStack {
                                        Text(participant.name)
                                        Spacer()
                                        
                                        if selectedParticipants.contains(participant) {
                                            Image(systemName: "checkmark")
                                                .foregroundColor(.blue)
                                            Circle()
                                                .font(.system(size: 17))
                                        }
                                    }
                                }
                            }
                        } label: {
                            Image(systemName: "chevron.right")
                                .rotationEffect(Angle(degrees: 90))
                                .foregroundColor(.black)
                        }
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
                        if !name.isEmpty && !discount.isEmpty && !note.isEmpty {
                            
                            let coupon = Coupon(name: name, discount: discount, clients: selectedParticipants, notes: note)
                            viewModel.addCoupon(coupon)
                            
                            isPresented = false
                        }
                    } label: {
                        HStack {
                            Image(systemName: "checkmark.square.fill")
                            Text("Add")
                        }.foregroundColor(Color.white)
                            .font(.system(size: 17))
                            .frame(maxWidth: .infinity)
                    }.frame(height: 88).background(!name.isEmpty && !discount.isEmpty && !note.isEmpty ? Color.red : Color.red.opacity(0.5) )
                        .cornerRadius(12).padding(.horizontal, -16)
                        
                    
                }.padding(.horizontal)
                .frame(maxWidth: .infinity)
                .background(Color.sheet)
                .cornerRadius(20)
            }.edgesIgnoringSafeArea(.bottom)
        }
    }
    
    func toggleSelection(for participant: Client) {
        if let index = selectedParticipants.firstIndex(of: participant) {
            selectedParticipants.remove(at: index)
        } else {
            selectedParticipants.append(participant)
        }
    }
}
#Preview {
    AddCouponsUIView(viewModel: SettingsViewModel(), homeVM: HomeViewModel(), isPresented: .constant(true))
}

#Preview {
    EditCouponsUIView(viewModel: SettingsViewModel(), homeVM: HomeViewModel(), isPresented: .constant(true), coupon: .constant(Coupon(name: "", discount: "", clients: [], notes: "")))
}

struct EditCouponsUIView: View {
    @ObservedObject var viewModel: SettingsViewModel
    @ObservedObject var homeVM: HomeViewModel
    @Binding var isPresented: Bool
    
    @Binding var coupon: Coupon
    
    @State private var name = ""
    @State private var discount = ""
    @State private var note = ""
    
    @State private var selectedParticipants: [Client] = []
    
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
                        Text("Edit coupon")
                            .font(.system(size: 20, weight: .semibold))
                        Spacer()
                    }
                    
                    
                    HStack(spacing: 10) {
                        Text("Name")
                        TextField("Discount on your first haircut", text: $name)
                    }.padding()
                        .background(Color.white).cornerRadius(10)
                    
                    HStack(spacing: 10) {
                        Text("Discount")
                        TextField("Get 20% off your first haircut at our salon!", text: $discount)
                    }.padding()
                        .background(Color.white).cornerRadius(10)
                     
                    HStack(spacing: 10) {
                        Text("Clients")
                        Text("\(selectedParticipants.count)")
                            .foregroundColor(.black.opacity(0.23))
                        Spacer()
                        Menu {
                            // Перебираем всех участников и создаем элементы меню
                            ForEach(homeVM.clients, id: \.self) { participant in
                                Button(action: {
                                    toggleSelection(for: participant)
                                }) {
                                    HStack {
                                        Text(participant.name)
                                        Spacer()
                                        
                                        if selectedParticipants.contains(participant) {
                                            Image(systemName: "checkmark")
                                                .foregroundColor(.blue)
                                            Circle()
                                                .font(.system(size: 17))
                                        }
                                    }
                                }
                            }
                        } label: {
                            Image(systemName: "chevron.right")
                                .rotationEffect(Angle(degrees: 90))
                                .foregroundColor(.black)
                        }
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
                        .onAppear {
                            
                            name = coupon.name
                            discount = coupon.discount
                            selectedParticipants = coupon.clients
                            note = coupon.notes
                            
                        }
                    Spacer()
                    Button {
                        if !name.isEmpty && !discount.isEmpty && !note.isEmpty {
                          
                            viewModel.updateCoupon(for: coupon, name: name, discount: discount, clients: selectedParticipants, notes: note)
                            isPresented = false
                        }
                    } label: {
                        HStack {
                            Image(systemName: "checkmark.square.fill")
                            Text("Edit")
                        }.foregroundColor(Color.white)
                            .font(.system(size: 17))
                            .frame(maxWidth: .infinity)
                    }.frame(height: 88).background(!name.isEmpty && !discount.isEmpty && !note.isEmpty ? Color.red : Color.red.opacity(0.5) )
                        .cornerRadius(12).padding(.horizontal, -16)
                        
                    
                }.padding(.horizontal)
                .frame(maxWidth: .infinity)
                .background(Color.sheet)
                .cornerRadius(20)
            }.edgesIgnoringSafeArea(.bottom)
        }
    }
    
    func toggleSelection(for participant: Client) {
        if let index = selectedParticipants.firstIndex(of: participant) {
            selectedParticipants.remove(at: index)
        } else {
            selectedParticipants.append(participant)
        }
    }
}
