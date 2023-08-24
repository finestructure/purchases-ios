//
//  Copyright RevenueCat Inc. All Rights Reserved.
//
//  Licensed under the MIT License (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      https://opensource.org/licenses/MIT
//
//  ConfigurationTests.swift
//
//  Created by Nacho Soto on 5/16/22.

import Foundation
import Nimble
import XCTest

@testable import RevenueCat

class ConfigurationTests: TestCase {

    func testValidateAPIKeyWithPlatformSpecificKey() {
        expect(Configuration.validate(apiKey: "appl_1a2b3c4d5e6f7h")) == .validApplePlatform
    }

    func testValidateAPIKeyWithInvalidPlatformKey() {
        expect(Configuration.validate(apiKey: "goog_1a2b3c4d5e6f7h")) == .otherPlatforms
    }

    func testValidateAPIKeyWithLegacyKey() {
        expect(Configuration.validate(apiKey: "swRTCezdEzjnJSxdexDNJfcfiFrMXwqZ")) == .legacy
    }

    @available(*, deprecated)
    func testObserverModeDefaultsToStoreKit1() {
        let observerMode = Bool.random()

        let configuration = Configuration.Builder(withAPIKey: "test")
            .with(observerMode: observerMode)
            .build()

        expect(configuration.observerMode) == observerMode
        expect(configuration.storeKit2Setting) == .enabledOnlyForOptimizations
    }

    func testObserverModeWithStoreKit2Disabled() {
        let configuration = Configuration.Builder(withAPIKey: "test")
            .with(observerMode: true, storeKit2: false)
            .build()

        expect(configuration.observerMode) == true
        expect(configuration.storeKit2Setting) == .enabledOnlyForOptimizations
    }

    func testObserverModeWithStoreKit2Enabled() {
        let configuration = Configuration.Builder(withAPIKey: "test")
            .with(observerMode: true, storeKit2: true)
            .build()

        expect(configuration.observerMode) == true
        expect(configuration.storeKit2Setting) == .enabledForCompatibleDevices
    }

}
