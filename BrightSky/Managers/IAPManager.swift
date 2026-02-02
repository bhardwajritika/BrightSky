//
//  IAPManager.swift
//  BrightSky
//
//  Created by Tarun Sharma on 08/01/26.
//

// InAppPurchaseManager
// TODO: Bring in RevenueCat

import RevenueCat
import Foundation

final class IAPManager {
    static let shared = IAPManager()
    
    private init() {}
    
    func isSubscribed(completion: @escaping (Bool) -> Void) {
        Purchases.shared.getCustomerInfo {
            info , error in
            guard let subscriptions = info?.activeSubscriptions else {
                return
            }
            print(subscriptions)
            completion(!subscriptions.isEmpty)
        }
    }
}
