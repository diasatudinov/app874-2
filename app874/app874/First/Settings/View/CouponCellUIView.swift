//
//  CouponCellUIView.swift
//  app874
//
//  Created by Dias Atudinov on 05.09.2024.
//

import SwiftUI

struct CouponCellUIView: View {
    @State var coupon: Coupon
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.white)
                .cornerRadius(16)
                .shadow(radius: 3).opacity(0.4)
            VStack(spacing: 10) {
                Text(coupon.name)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.mainGreen)
                    .padding(.bottom, 5)
                Text(coupon.discount)
                    .font(.system(size: 15))
                    .foregroundColor(.black)
                Text(coupon.notes)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 13))
                    .foregroundColor(.black.opacity(0.5))
                
                Text("Clients")
                    .font(.system(size: 15, weight: .bold))
                    .foregroundColor(.black)
                    .padding(.bottom, 5)
                HStack() {
                    ForEach(coupon.clients.prefix(8), id: \.self) { client in
                        if let image = client.image {
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .clipShape(Circle())
                                .frame(height: 52)
                                .padding(.leading, -25)
                            
                        } else {
                            Circle()
                                .foregroundColor(.gray.opacity(0.3))
                                .frame(height: 42)
                                .padding(.leading, -25)
                        }
                        
                    }
                }.padding(.leading, 25).padding(.bottom)
                
                HStack {
                    Spacer()
                    Button {
                        //isEditClientSheetPresented = true
                    } label: {
                        Text("Edit")
                            .font(.system(size: 12, weight: .semibold))
                            .padding(4).padding(.horizontal)
                            .foregroundColor(.white)
                            .background(Color.red)
                            .cornerRadius(12)
                    }
                    
                    Button {
                       // viewModel.deleteClient(for: client)
                    } label: {
                        Text("Delete")
                            .font(.system(size: 12, weight: .semibold))
                            .padding(4).padding(.horizontal)
                            .foregroundColor(.black)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.mainGreen, lineWidth: 1)
                            )
                    }
                    Spacer()
                }
            }.padding(.horizontal)
        }.frame(height: 302)
    }
}

#Preview {
    CouponCellUIView(coupon: Coupon(name: "Discount on your first haircut", discount: "Get 20% off your first haircut at our salon!", clients: [Client(name: "", proceduresPerformed: 0, totalProcedures: 0, income: "", email: "", number: "", note: ""),Client(name: "", proceduresPerformed: 0, totalProcedures: 0, income: "", email: "", number: "", note: ""),Client(name: "", proceduresPerformed: 0, totalProcedures: 0, income: "", email: "", number: "", note: ""),Client(name: "", proceduresPerformed: 0, totalProcedures: 0, income: "", email: "", number: "", note: "")], notes: "Coupon is valid for new customers only. Cannot be combined with other offers"))
}
