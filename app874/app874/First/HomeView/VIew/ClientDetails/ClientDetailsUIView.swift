//
//  ClientDetailsUIView.swift
//  app874
//
//  Created by Dias Atudinov on 04.09.2024.
//

import SwiftUI

struct ClientDetailsUIView: View {
    @ObservedObject var viewModel: HomeViewModel
    @Binding var client: Client
    @State private var selectedTab: Tab = .services
    @State private var isAddSheetShowed = false
    @State private var isEditSheetPresented = false
    
    var body: some View {
        ZStack {
            VStack {
                
                if let image = client.image {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 99)
                        .clipShape(Circle())
                    
                } else {
                    Circle()
                        .foregroundColor(.gray.opacity(1))
                        .frame(width: 99, height: 99)
                }
                
                ZStack {
                    Color.mainGreen.opacity(0.1)
                    
                    VStack(spacing: 5) {
                        Text(client.name)
                            .font(.system(size: 22, weight: .bold))
                        Text(client.email)
                            .foregroundColor(.black.opacity(0.5))
                        Text(client.number)
                            .foregroundColor(.black.opacity(0.5))
                        HStack {
                            Text("Notes")
                                .font(.system(size: 13))
                                .foregroundColor(.black.opacity(0.5))
                            Spacer()
                        }
                        
                        VStack() {
                            ScrollView {
                                Text(client.note)
                                
                                    .multilineTextAlignment(.leading)
                                
                                
                            }.frame(maxWidth: .infinity).padding(10)
                        }.frame(height: 81).frame(maxWidth: .infinity).overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.mainGreen, lineWidth: 1)
                        ).padding(.bottom, 15)
                        
                        Button {
                            isEditSheetPresented = true
                        } label: {
                            Text("Edit profile")
                                .foregroundColor(.white)
                                .font(.system(size: 12, weight: .semibold))
                                .padding(4).padding(.horizontal, 18)
                                .background(Color.red)
                                .cornerRadius(12)
                        }
                        
                        Spacer()
                    }.padding(.top, 55).padding(.horizontal)
                }.cornerRadius(16).frame(height: 310).padding(.top, -55)
            
                Picker("Select a tab", selection: $selectedTab) {
                    Text("Services").tag(Tab.services)
                    Text("Story").tag(Tab.story)
                }.pickerStyle(SegmentedPickerStyle())
                    .onAppear {
                        //UISegmentedControl.appearance().selectedSegmentTintColor = UIColor.gray
                        
                        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
                        let titleTextAttributesSelected = [NSAttributedString.Key.foregroundColor: UIColor.black]
                        UISegmentedControl.appearance().setTitleTextAttributes(titleTextAttributes, for: .normal)
                        UISegmentedControl.appearance().setTitleTextAttributes(titleTextAttributesSelected, for: .selected)
                    }
                
                if selectedTab == .services {
                    ScrollView {
                        ForEach(client.services, id: \.self) { service in
                            ServiceCellUIView(viewModel: viewModel, client: $client, service: service)
                        }
                    }
                } else {
                    ScrollView {
                        ForEach(client.story, id: \.self) { story in
                            ServiceCellUIView(viewModel: viewModel, client: $client, service: story).opacity(0.7)
                        }
                    }
                }
                
                Spacer()
                Button {
                    isAddSheetShowed = true
                } label: {
                    HStack {
                        Image(systemName: "checkmark.square.fill")
                        Text("Add service")
                    }.foregroundColor(Color.white)
                        .font(.system(size: 17))
                        .frame(maxWidth: .infinity)
                }.frame(height: 88).background(Color.red)
                    .cornerRadius(12).padding(.horizontal, -16)
            }.padding(.horizontal).edgesIgnoringSafeArea(.bottom)
                .sheet(isPresented: $isAddSheetShowed) {
                    AddServiceUIView(viewModel: viewModel, client: $client, showSheet: $isAddSheetShowed)
                }
                .sheet(isPresented: $isEditSheetPresented) {
                    EditSheetClientView(viewModel: viewModel, isPresented: $isEditSheetPresented, client: $client)
                }
        }.navigationTitle(Text("Client profile"))
    }
}

#Preview {
    ClientDetailsUIView(viewModel: HomeViewModel(), client: .constant(Client(name: "Eleanor Pena", proceduresPerformed: 20, totalProcedures: 40, income: "$200", email: "EleanorPena@example.com", number: "(603) 555-0123", note: "1. Prefers cascading haircuts \n2. Allergic to chemical hair dyes \n(causes itching   and irritation)", services: [Service(name: "aaaa", price: "", date: Date(), notes: "")], story: [Service(name: "fffff", price: "", date: Date(), notes: "")])))
}

enum Tab {
    case services, story
}
