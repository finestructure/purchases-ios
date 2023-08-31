//
//  ConfigurationAPI.swift
//  SwiftAPITester
//
//  Created by Joshua Liebowitz on 5/6/22.
//

import Foundation
import RevenueCat

func checkConfigurationAPI() {
    let builder = Configuration
        .builder(withAPIKey: "")
        .with(apiKey: "")
        .with(appUserID: "")
        .with(appUserID: nil)
        .with(observerMode: true)
        .with(observerMode: false, storeKitVersion: .storeKit1)
        .with(observerMode: true, storeKitVersion: .storeKit2)
        .with(userDefaults: UserDefaults.standard)
        .with(dangerousSettings: DangerousSettings())
        .with(dangerousSettings: DangerousSettings(autoSyncPurchases: true))
        .with(networkTimeout: 1)
        .with(storeKit1Timeout: 1)
        .with(platformInfo: Purchases.PlatformInfo(flavor: "", version: ""))

    let _: Configuration = builder.build()

    if #available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.2, *) {
        let _: Configuration = builder
            .with(entitlementVerificationMode: .informational)
            .build()
    }
}

func checkStoreKitVersion(_ version: Configuration.StoreKitVersion) {
    switch version {
    case .storeKit1: break
    case .storeKit2: break
    @unknown default: break
    }
}

@available(*, deprecated)
func checkDeprecatedConfiguration(_ builder: Configuration.Builder) {
    _ = builder
        .with(usesStoreKit2IfAvailable: false)
}
