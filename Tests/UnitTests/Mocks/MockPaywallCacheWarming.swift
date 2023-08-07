//
//  Copyright RevenueCat Inc. All Rights Reserved.
//
//  Licensed under the MIT License (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      https://opensource.org/licenses/MIT
//
//  MockPaywallCacheWarming.swift
//
//  Created by Nacho Soto on 8/7/23.

import Foundation
@testable import RevenueCat

final class MockPaywallCacheWarming: PaywallCacheWarmingType {

    private let _invokedWarmUpEligibilityCache: Atomic<Bool> = false
    private let _invokedWarmUpEligibilityCacheOfferings: Atomic<Offerings?> = nil

    var invokedWarmUpEligibilityCache: Bool {
        get { return self._invokedWarmUpEligibilityCache.value }
        set { self._invokedWarmUpEligibilityCache.value = newValue }
    }

    var invokedWarmUpEligibilityCacheOfferings: Offerings? {
        get { return self._invokedWarmUpEligibilityCacheOfferings.value }
        set { self._invokedWarmUpEligibilityCacheOfferings.value = newValue }
    }

    func warmUpEligibilityCache(offerings: Offerings) {
        self.invokedWarmUpEligibilityCache = true
        self.invokedWarmUpEligibilityCacheOfferings = offerings
    }

}
