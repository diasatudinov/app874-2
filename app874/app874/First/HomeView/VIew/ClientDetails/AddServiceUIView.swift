//
//  AddServiceUIView.swift
//  app874
//
//  Created by Dias Atudinov on 04.09.2024.
//

import SwiftUI

struct AddServiceUIView: View {
    @ObservedObject var viewModel: HomeViewModel
    
    @State private var name: String = ""
    @State private var price: String = ""
    @State private var selectedDate: Date = Date()
    @State private var selectedTime: Date = Date()
    @State private var selectedNotifTime: Date = Date()
    @State private var notes: String = ""
    @Binding var client: Client
    @Binding var showSheet: Bool
    
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
                            showSheet = false
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
                        Text("Create services")
                            .font(.system(size: 20, weight: .semibold))
                        Spacer()
                    }
                    
                    HStack(spacing: 10) {
                        Text("Name")
                        TextField("Paving", text: $name)
                    }.padding()
                        .background(Color.white).cornerRadius(10)
                    
                    HStack(spacing: 10) {
                        Text("Price")
                        TextField("$14,35", text: $price)
                    }.padding()
                        .background(Color.white).cornerRadius(10)
                    
                    HStack(spacing: 10) {
                        DatePicker("Date", selection: $selectedDate, displayedComponents: .date)
                            .accentColor(.mainGreen)
                    }.padding()
                        .background(Color.white).cornerRadius(10)
                    
                    HStack(spacing: 10) {
                        DatePicker("Time", selection: $selectedTime, displayedComponents: .hourAndMinute)
                    }.padding()
                        .background(Color.white).cornerRadius(10)
                    
                    HStack(spacing: 10) {
                        Image(systemName: "bell")
                        DatePicker("", selection: $selectedNotifTime, displayedComponents: .hourAndMinute)
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
                        let combinedDateTime = combineDateAndTime(date: selectedDate, time: selectedTime)
                        viewModel.addService(for: client, name: name, price: price, date: combinedDateTime, notes: notes)
                        showSheet = false
                        
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

                
                
                    
                
                
            }.edgesIgnoringSafeArea(.bottom)
            
            
            
            
            
            
        }
    }
    
    private func combineDateAndTime(date: Date, time: Date) -> Date {
        let calendar = Calendar.current
        
        let dateComponents = calendar.dateComponents([.year, .month, .day], from: date)
        let timeComponents = calendar.dateComponents([.hour, .minute], from: time)
        
        var combinedComponents = DateComponents()
        combinedComponents.year = dateComponents.year
        combinedComponents.month = dateComponents.month
        combinedComponents.day = dateComponents.day
        combinedComponents.hour = timeComponents.hour
        combinedComponents.minute = timeComponents.minute
        
        return calendar.date(from: combinedComponents) ?? Date()
    }
}

#Preview {
    AddServiceUIView(viewModel: HomeViewModel(), client: .constant(Client(name: "", proceduresPerformed: 0, totalProcedures: 0, income: "", email: "", number: "", note: "")), showSheet: .constant(false))
}


struct EditServiceUIView: View {
    @ObservedObject var viewModel: HomeViewModel
    
    @State private var name: String = ""
    @State private var price: String = ""
    @State private var selectedDate: Date = Date()
    @State private var selectedTime: Date = Date()
    @State private var selectedNotifTime: Date = Date()
    @State private var notes: String = ""
    @Binding var client: Client
    @Binding var service: Service
    @Binding var showSheet: Bool
    
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
                            showSheet = false
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
                        Text("Create services")
                            .font(.system(size: 20, weight: .semibold))
                        Spacer()
                    }
                    
                    HStack(spacing: 10) {
                        Text("Name")
                        TextField("Paving", text: $name)
                    }.padding()
                        .background(Color.white).cornerRadius(10)
                    
                    HStack(spacing: 10) {
                        Text("Price")
                        TextField("$14,35", text: $price)
                    }.padding()
                        .background(Color.white).cornerRadius(10)
                    
                    HStack(spacing: 10) {
                        DatePicker("Date", selection: $selectedDate, displayedComponents: .date)
                            .accentColor(.mainGreen)
                    }.padding()
                        .background(Color.white).cornerRadius(10)
                    
                    HStack(spacing: 10) {
                        DatePicker("Time", selection: $selectedTime, displayedComponents: .hourAndMinute)
                    }.padding()
                        .background(Color.white).cornerRadius(10)
                    
                    HStack(spacing: 10) {
                        Image(systemName: "bell")
                        DatePicker("", selection: $selectedNotifTime, displayedComponents: .hourAndMinute)
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
                        let combinedDateTime = combineDateAndTime(date: selectedDate, time: selectedTime)
                        
                        viewModel.updateService(for: client, for: service, name: name, price: price, date: combinedDateTime, notes: notes)
                        showSheet = false
                        
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
                    name = service.name
                    price = service.price
                    selectedDate = service.date
                    selectedTime = service.date
                    selectedNotifTime = service.date
                    notes = service.notes
                }

                
                
                    
                
                
            }.edgesIgnoringSafeArea(.bottom)
            
            
            
            
            
            
        }
    }
    
    private func combineDateAndTime(date: Date, time: Date) -> Date {
        let calendar = Calendar.current
        
        let dateComponents = calendar.dateComponents([.year, .month, .day], from: date)
        let timeComponents = calendar.dateComponents([.hour, .minute], from: time)
        
        var combinedComponents = DateComponents()
        combinedComponents.year = dateComponents.year
        combinedComponents.month = dateComponents.month
        combinedComponents.day = dateComponents.day
        combinedComponents.hour = timeComponents.hour
        combinedComponents.minute = timeComponents.minute
        
        return calendar.date(from: combinedComponents) ?? Date()
    }
}

#Preview {
    EditServiceUIView(viewModel: HomeViewModel(), client: .constant(Client(name: "", proceduresPerformed: 0, totalProcedures: 0, income: "", email: "", number: "", note: "")), service: .constant(Service(name: "Hair wash", price: "$20", date: Date(), notes: "Wahsing hair \nusing all soaps")), showSheet: .constant(false))
}
