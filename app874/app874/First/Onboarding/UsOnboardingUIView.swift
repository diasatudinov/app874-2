//
//  UsOnboardingUIView.swift
//  app874
//
//  Created by Dias Atudinov on 03.09.2024.
//

import SwiftUI
import StoreKit

struct UsOnboardingUIView: View {
    
    @State private var progress: Double = 0.0
    @State private var timer: Timer?
    @State private var isLoadingView: Bool = true
    @State private var isNotificationView: Bool = true
    @State private var pageNum: Int = 1
    @AppStorage("onboardingShowed") var onboardingShowed: Bool = false

    var body: some View {
        if !onboardingShowed {
            if pageNum < 3 {
                ZStack {   
                    Color.onboardingBg
                        .ignoresSafeArea()
                    
                    ZStack {
                        VStack {
                            Spacer()
                            switch pageNum {
                            case 1:
                                ZStack {
                                    VStack {
                                        Spacer()
                                        Image("firstScreen874")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(height: 500)
                                            .padding(.bottom, -35)
                                        Spacer()
                                    }
                                }.padding(.top, UIScreen.main.bounds.height/6)
                            case 2: Image("ratings874")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: UIScreen.main.bounds.width)
                                    .ignoresSafeArea()
                            default:
                                Image("notifications874")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 500)
                                    .ignoresSafeArea()
                            }
                            
                            
                            
                        }
                        VStack {
                            HStack(spacing: 8) {
                                Rectangle()
                                    .fill(pageNum == 1 ? Color.red : Color.gray.opacity(0.5))
                                    .frame(width: 132, height: 6) 
                                    .cornerRadius(19)
                                
                                Rectangle()
                                    .fill(pageNum == 2 ? Color.red : Color.gray.opacity(0.5))
                                    .frame(width: 132, height: 6)
                                    .cornerRadius(19)
                                
                            }
                            .padding(.top)
                            .padding(.bottom, 24)
                            switch pageNum {
                            case 1:
                                VStack(spacing: 12) {
                                    Text("Start playing and \nearning")
                                        .font(.system(size: 34, weight: .bold))
                                        .multilineTextAlignment(.center)
                                        .multilineTextAlignment(.center)
                                    Text("Choose yoga exercises. Create instruction cards and personalise them to suit your goals")
                                        .font(.system(size: 16, weight: .semibold))
                                        .multilineTextAlignment(.center)
                                }.frame(height: 160).padding(.bottom, 10).padding(.horizontal, 30).foregroundColor(.white)
                                
                            case 2:
                                VStack(spacing: 12) {
                                    Text("Rate our app in the \nAppStore")
                                        .font(.system(size: 34, weight: .bold))
                                        .multilineTextAlignment(.center)
                                        .multilineTextAlignment(.center)
                                    Text("Help make the app even better")
                                        .font(.system(size: 16, weight: .semibold))
                                        .multilineTextAlignment(.center)
                                }.frame(height: 160).padding(.bottom, 10).padding(.horizontal, 30).foregroundColor(.white)
                                    .onAppear{
                                        rateApp()
                                    } 
                            default:
                                Text("Don’t miss anything")
                                    .font(.title)
                                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                    .foregroundColor(.black)
                                    .padding(.bottom, 10)
                                Text("Don’t miss the most userful information")
                                    .foregroundColor(.white).opacity(0.7)
                                
                            }
                            
                        }.padding(.bottom, UIScreen.main.bounds.height * 2/3.2)
                        
                        VStack {
                            Spacer()
                            Button {
                                if pageNum < 3 {
                                    pageNum += 1
                                } else {
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
                    
                }
            } else {
                if isNotificationView {
                    ZStack {
                        Color.onboardingBg
                            .ignoresSafeArea()
                        
                        ZStack {
                            VStack {
                                Spacer()
                                
                                Image("notifications874")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 600)
                                    .padding(.bottom, -35)
                                
                            } 
                            
                            VStack {
                                Spacer()
                                
                                Button {
                                    isNotificationView = false
                                    onboardingShowed = true
                                } label: {
                                    
                                    Text("Next")
                                        .foregroundColor(Color.white)
                                        .font(.system(size: 22, weight: .bold))
                                        .padding()
                                        .frame(maxWidth: .infinity)
                                }.frame(height: 88).background(Color.red)
                                    .cornerRadius(12)
                            }.ignoresSafeArea()
                            VStack {
                                VStack(spacing: 12) {
                                    Text("Manage your orders")
                                        .font(.title)
                                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                        .multilineTextAlignment(.center)
                                    Text("Add new orders, schedule time and track each stage of completion")
                                        .font(.system(size: 16, weight: .semibold))
                                        .multilineTextAlignment(.center)
                                }.frame(height: 100).padding(.bottom, 10).padding(.horizontal, 30).foregroundColor(.white)
                            }.padding(.bottom, UIScreen.main.bounds.height * 2/2.6)
                        }
                    }
                    
                } else {
                    //WebUIView()
                }
            }
        } else {
           // WebUIView()
        }
    }
    
    func startTimer() {
        timer?.invalidate()
        progress = 0
        timer = Timer.scheduledTimer(withTimeInterval: 0.07, repeats: true) { timer in
            if progress < 100 {
                progress += 1
            } else {
                timer.invalidate()
                isLoadingView.toggle()
            }
        }
    }
    
    func rateApp() {
        SKStoreReviewController.requestReview()
    }
}
    

#Preview {
    UsOnboardingUIView()
}
