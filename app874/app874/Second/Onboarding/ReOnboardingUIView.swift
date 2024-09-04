//
//  ReOnboardingUIView.swift
//  app874
//
//  Created by Dias Atudinov on 03.09.2024.
//

import SwiftUI

struct ReOnboardingUIView: View {
    @State private var pageNum: Int = 1
    @State private var showSheet = false
    @AppStorage("signedUP") var signedUP: Bool = false
    
    var body: some View {
        if !signedUP {
            ZStack {
                Color.onboardingBg
                    .ignoresSafeArea()
                VStack(spacing: 0) {
                    Spacer()
                    switch pageNum {
                    case 1: Image("app874Screen1")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 600)
                            .padding(.bottom, -35)
                    case 2: Image("app874Screen2")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 600)
                            .padding(.bottom, -35)
                    case 3: Image("app874Screen3")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 600)
                            .padding(.bottom, -35)
                    default:
                        Image("appScreen3")
                            .resizable()
                            .frame(height: 549)
                            .ignoresSafeArea()
                    }
                    
                    
                    
                }
                VStack {
                    HStack(spacing: 8) {
                        Rectangle()
                            .fill(pageNum == 1 ? Color.red : Color.gray.opacity(0.5))
                            .frame(width: 86, height: 6)
                            .cornerRadius(19)
                        
                        Rectangle()
                            .fill(pageNum == 2 ? Color.red : Color.gray.opacity(0.5))
                            .frame(width: 86, height: 6)
                            .cornerRadius(19)
                        
                        Rectangle()
                            .fill(pageNum > 2 ? Color.red : Color.gray.opacity(0.5))
                            .frame(width: 86, height: 6)
                            .cornerRadius(19)
                    }
                    .padding()
                    switch pageNum {
                    case 1:
                        VStack(spacing: 12) {
                            Text("Track your progress")
                                .font(.title)
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                .multilineTextAlignment(.center)
                            Text("The app will help you keep track of the number of orders you have completed and see your progress")
                                .font(.system(size: 16, weight: .semibold))
                                .multilineTextAlignment(.center)
                        }.frame(height: 100).padding(.bottom, 10).padding(.horizontal, 30).foregroundColor(.white)
                    case 2:
                        VStack(spacing: 12) {
                            Text("Manage your orders")
                                .font(.title)
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                .multilineTextAlignment(.center)
                            Text(" Add new orders, schedule time and track each stage of completion")
                                .font(.system(size: 16, weight: .semibold))
                                .multilineTextAlignment(.center)
                        }.frame(height: 100).padding(.bottom, 10).padding(.horizontal, 30).foregroundColor(.white)
                    case 3:
                        VStack(spacing: 12) {
                            Text("Discounts")
                                .font(.title)
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                .multilineTextAlignment(.center)
                            Text("Create discounts for your customers in our app so you don't lose out")
                                .font(.system(size: 16, weight: .semibold))
                                .multilineTextAlignment(.center)
                        }.frame(height: 100).padding(.bottom, 10).padding(.horizontal, 30).foregroundColor(.white)
                    default:
                        Text("Save information about \nyour favorite routes")
                            .font(.title)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .frame(height: 70)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                            .padding(.bottom, 10)
                        
                    }
                    
                }.padding(.bottom, UIScreen.main.bounds.height * 2/2.8)
                
                VStack {
                    Spacer()
                    Button {
                        if pageNum < 3 {
                            pageNum += 1
                        } else {
                            signedUP = true
                        }
                    } label: {
                        Text("Next")
                            .foregroundColor(Color.white)
                            .font(.system(size: 22, weight: .bold))
                            .padding()
                            .frame(maxWidth: .infinity)
                    }.frame(height: 88).background(Color.red)
                        .cornerRadius(12)
                        
                }.ignoresSafeArea()
            }
        
            
        } else {
            TabUIView()
        }
    }
}

#Preview {
    ReOnboardingUIView()
}
