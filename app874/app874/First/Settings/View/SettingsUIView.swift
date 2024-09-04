//
//  SettingsUIView.swift
//  app874
//
//  Created by Dias Atudinov on 04.09.2024.
//

import SwiftUI

struct SettingsUIView: View {
    @ObservedObject var viewModel = SettingsViewModel()
    var body: some View {
        ZStack {
            VStack(spacing: 10) {
                HStack {
                    Text("Settings")
                        .font(.system(size: 34, weight: .bold))
                        .foregroundColor(.black)
                    Spacer()
                    
                    
                }
                NavigationLink {
                    
                } label: {
                    ZStack {
                        Rectangle()
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .shadow(radius: 3).opacity(0.4)
                        HStack {
                            Image(systemName: "flame")
                            Text("Discounts and coupons")
                            Spacer()
                            Image(systemName: "chevron.right")
                        }.padding(.horizontal)
                    }.frame(height: 50)
                }
                
                Button {
                    viewModel.rateApp()
                } label: {
                    ZStack {
                        Rectangle()
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .shadow(radius: 3).opacity(0.4)
                        HStack {
                            Image(systemName: "star.square")
                            Text("Rate our app")
                            Spacer()
                            Image(systemName: "chevron.right")
                        }.padding(.horizontal)
                    }.frame(height: 50)
                }
                
                Button {
                    viewModel.openUsagePolicy()
                } label: {
                    ZStack {
                        Rectangle()
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .shadow(radius: 3).opacity(0.4)
                        HStack {
                            Image(systemName: "doc.text.magnifyingglass")
                            Text("Usage Policy")
                            Spacer()
                            Image(systemName: "chevron.right")
                        }.padding(.horizontal)
                    }.frame(height: 50)
                }
                
                Button {
                    viewModel.shareApp()
                } label: {
                    ZStack {
                        Rectangle()
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .shadow(radius: 3).opacity(0.4)
                        HStack {
                            Image(systemName: "square.and.arrow.up")
                            Text("Share our app")
                            Spacer()
                            Image(systemName: "chevron.right")
                        }.padding(.horizontal)
                    }.frame(height: 50)
                }
                
                Spacer()
            }.padding(.horizontal).foregroundColor(.black)
        }
    }
}

#Preview {
    SettingsUIView()
}
