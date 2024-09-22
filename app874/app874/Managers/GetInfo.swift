//
//  GetInfo.swift
//  app874
//
//  Created by Dias Atudinov on 22.09.2024.
//

import UIKit
import CoreTelephony

struct DeviceData {
    var isVPNActive: Bool
    var isCharging: Bool
    var batteryLevel: Double
}



struct DeviceInfo {
    
    static func collectData() -> DeviceData {
        
        var isConnectedToVpn: Bool {
            
            let vpnProtocolsKeysIdentifiers = [
                "tap", "tun", "ppp", "ipsec", "utun", "ipsec0", "utun1", "utun2"
            ]
            
            guard let cfDict = CFNetworkCopySystemProxySettings() else { return false }
            
            let nsDict = cfDict.takeRetainedValue() as NSDictionary
            
            guard let keys = nsDict["__SCOPED__"] as? NSDictionary,
                  let allKeys = keys.allKeys as? [String] else { return false }
            for key in allKeys {
                
                for protocolId in vpnProtocolsKeysIdentifiers
                        
                where key.starts(with: protocolId) {
                    
                    return true
                }
            }
            
            return false
        }
        
        UIDevice.current.isBatteryMonitoringEnabled = true
        let batteryLevel = Double(UIDevice.current.batteryLevel)
        
        return DeviceData(
            isVPNActive: isConnectedToVpn,
            isCharging: UIDevice.current.batteryState == .charging,
            batteryLevel: batteryLevel
        )
    }
}

