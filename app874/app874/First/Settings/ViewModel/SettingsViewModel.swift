//
//  SettingsViewModel.swift
//  app874
//
//  Created by Dias Atudinov on 04.09.2024.
//

import SwiftUI
import StoreKit

class SettingsViewModel: ObservableObject {
    @Published var coupons: [Coupon] = [] {
        didSet {
            saveCoupons()
        }
    }
    
    private let couponsFileName = "coupons.json"
    
    init() {
        loadCoupons()
    }
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    private func couponsFilePath() -> URL {
        return getDocumentsDirectory().appendingPathComponent(couponsFileName)
    }
    
    private func saveCoupons() {
        DispatchQueue.global().async {
            let encoder = JSONEncoder()
            do {
                let data = try encoder.encode(self.coupons)
                try data.write(to: self.couponsFilePath())
            } catch {
                print("Failed to save players: \(error.localizedDescription)")
            }
        }
    }
    
    private func loadCoupons() {
        let decoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: couponsFilePath())
            coupons = try decoder.decode([Coupon].self, from: data)
        } catch {
            print("Failed to load players: \(error.localizedDescription)")
        }
    }
    
    func updateCoupon(for coupon: Coupon, name: String, discount: String, clients: [Client], notes: String) {
        
        if let index = coupons.firstIndex(where: { $0.id == coupon.id }) {
            coupons[index].name = name
            coupons[index].discount = discount
            coupons[index].clients = clients
            coupons[index].notes = notes
            
        }
    }
    
    func deleteCoupon(for coupon: Coupon) {
        if let index = coupons.firstIndex(where: { $0.id == coupon.id }) {
            coupons.remove(at: index)
        }
    }
    
    func addCoupon(_ coupon: Coupon) {
        coupons.append(coupon)
    }
    
    func shareApp() {
        guard let url = URL(string: "https://apps.apple.com/app/dafaski/id6633439878") else { return }
        let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootViewController = windowScene.windows.first?.rootViewController {
            rootViewController.present(activityVC, animated: true, completion: nil)
        }
    }
    
    func rateApp() {
        SKStoreReviewController.requestReview()
    }
    
    func openUsagePolicy() {
        guard let url = URL(string: "https://www.termsfeed.com/live/58023c7e-7f73-46fd-9717-e9b281701e26") else { return }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
}
 
