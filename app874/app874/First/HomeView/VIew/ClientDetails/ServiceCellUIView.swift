//
//  ServiceCellUIView.swift
//  app874
//
//  Created by Dias Atudinov on 04.09.2024.
//

import SwiftUI

struct ServiceCellUIView: View {
    @ObservedObject var viewModel: HomeViewModel
    @Binding var client: Client
    @State var service: Service
    @State private var isEditSheetPresented = false
    
    var body: some View {
        ZStack {
            Color.mainGreen.opacity(0.1)
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        HStack {
                            HStack {
                                Image(systemName: "calendar")
                                Text(formattedDate(service.date))
                            }.foregroundColor(.white).font(.system(size: 12)).padding(5).padding(.horizontal, 5)
                                .background(Color.mainGreen).cornerRadius(6)
                            
                            HStack {
                                Image(systemName: "clock")
                                Text(formattedTime(service.date))
                            }.foregroundColor(.white).font(.system(size: 12)).padding(5).padding(.horizontal, 5)
                                .background(Color.mainGreen).cornerRadius(6)
                            
                            Spacer()
                            Button {
                                isEditSheetPresented = true
                            } label: {
                                Image(systemName: "square.and.pencil")
                                    .foregroundColor(Color.mainGreen)
                                    .font(.system(size: 22))
                                    
                            }
                        }
                        
                        VStack(alignment: .leading) {
                            Text(service.name)
                                .foregroundColor(.black)
                                .font(.system(size: 17, weight: .semibold))
                                .padding(.bottom, 4)
                            
                            Text(service.notes)
                                .foregroundColor(.black.opacity(0.5))
                                .font(.system(size: 13))
                        }
                    }
                    
                    Spacer()
                    
                    
                }.padding(.bottom, 10)
                
                
                
                HStack {
                    Text("Price:")
                        .font(.system(size: 16))
                    Spacer()
                    Text(service.price)
                        .font(.system(size: 17, weight: .semibold))
                }
            }.padding(.horizontal)
                .sheet(isPresented: $isEditSheetPresented) {
                    EditServiceUIView(viewModel: viewModel, client: $client, service: $service, showSheet: $isEditSheetPresented)
                }
            
        }.frame(height: 165).cornerRadius(14)
        
    }
    
    private func formattedDate(_ date: Date) -> String {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd.MM.yyyy"
            return formatter.string(from: date)
        }
        
        private func formattedTime(_ date: Date) -> String {
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            return formatter.string(from: date)
        }
    
}

#Preview {
    ServiceCellUIView(viewModel: HomeViewModel(), client: .constant(Client(name: "Eleanor Pena", proceduresPerformed: 20, totalProcedures: 40, income: "$200", email: "EleanorPena@example.com", number: "(603) 555-0123", note: "1. Prefers cascading haircuts \n2. Allergic to chemical hair dyes \n(causes itching   and irritation)", services: [Service(name: "asdsadad", price: "", date: Date(), notes: "")])), service: Service(name: "Classic haircut", price: "$30,00", date: Date(), notes: "Customised classic haircut including hair washing and styling"))
}
//(viewModel: HomeViewModel(), client: .constant(Client(name: "Eleanor Pena", proceduresPerformed: 20, totalProcedures: 40, income: "$200", email: "EleanorPena@example.com", number: "(603) 555-0123", note: "1. Prefers cascading haircuts \n2. Allergic to chemical hair dyes \n(causes itching   and irritation)", services: [Service(name: "asdsadad", price: "", date: Date(), notes: "")])), service: Service(name: "Classic haircut", price: "$30,00", date: Date(), notes: "Customised classic haircut including hair washing and styling"), isEditServiceSheetPresented: .constant(false))
