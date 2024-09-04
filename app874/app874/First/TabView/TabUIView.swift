//
//  TabUIView.swift
//  app874
//
//  Created by Dias Atudinov on 04.09.2024.
//

import SwiftUI

struct TabUIView: View {
    @State var selectedTab = 0
    private let tabs = ["Home", "Profile", "Settings"]
    
    @ObservedObject var homeVM = HomeViewModel()
    @ObservedObject var procedureVM = ProcedureViewModel()
    
    var body: some View {
        ZStack {
            
            switch selectedTab {
            case 0:
                HomeUIView(viewModel: homeVM)
               // StatisticsUIView(viewModel: profileVM)
            case 1:
                ProceduresUIView(viewModel: procedureVM)

            case 2:
                SettingsUIView()
               // SettingsUIView()
            default:
                Text("default")
            }
                VStack {
                    Spacer()
                    
                    ZStack {
                        Rectangle()
                            .fill(Color.white)
                            .frame(height: 80)
                            
                        HStack(spacing: 80) {
                            ForEach(0..<tabs.count) { index in
                                Button(action: {
                                    selectedTab = index
                                }) {
                                    
                                    ZStack {
                                        VStack {
                                            Image(systemName: icon(for: index))
                                                .font(.system(size: 20, weight: .semibold))
                                                .padding(.bottom, 2)
                                            Text(text(for: index))
                                                .font(.system(size: 10, weight: .semibold))
                                        }.foregroundColor(selectedTab == index ? Color.mainGreen : Color.gray)
                                    }
                                }
                                
                            }
                        }.padding(.bottom, 25)
                        
                        Rectangle()
                            .fill(Color.black.opacity(1))
                            .frame(height: 0.3)
                            .padding(.bottom, 80)
                    }
                    
                }.ignoresSafeArea()
            
        }
    }
    
    private func icon(for index: Int) -> String {
        switch index {
        case 0: return "house"
        case 1: return "plus.rectangle.on.rectangle"
        case 2: return "gearshape"
        default: return ""
        }
    }
    
    private func text(for index: Int) -> String {
        switch index {
        case 0: return "Home"
        case 1: return "Procedures"
        case 2: return "Settings"
        default: return ""
        }
    }
}

#Preview {
    TabUIView()
}
