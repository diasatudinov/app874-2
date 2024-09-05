//
//  CouponsUIView.swift
//  app874
//
//  Created by Dias Atudinov on 05.09.2024.
//

import SwiftUI

struct CouponsUIView: View {
    @ObservedObject var viewModel: SettingsViewModel
    @ObservedObject var homeVM: HomeViewModel
    @State private var addCouponsSheet = false
    var body: some View {
        ZStack {
            VStack {
                ScrollView {
                    ForEach(viewModel.coupons, id: \.self) { coupon in
                        CouponCellUIView(coupon: coupon).padding(.horizontal)
                    }
                }
                Spacer()
                Button {
                    addCouponsSheet = true
                    
                } label: {
                    HStack {
                        Image(systemName: "checkmark.square.fill")
                        Text("Add discount")
                    }.foregroundColor(Color.white)
                        .font(.system(size: 17))
                        .frame(maxWidth: .infinity)
                }.frame(height: 88).background(Color.red)
                    .cornerRadius(12).padding(.horizontal, -16)
            }.edgesIgnoringSafeArea(.bottom)
                .sheet(isPresented: $addCouponsSheet) {
                    AddCouponsUIView(viewModel: viewModel, homeVM: homeVM, isPresented: $addCouponsSheet)
                }
        }.navigationTitle(Text("Discounts and coupons"))
    }
}

#Preview {
    CouponsUIView(viewModel: SettingsViewModel(), homeVM: HomeViewModel())
}
