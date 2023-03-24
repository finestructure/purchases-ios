//
//  Copyright RevenueCat Inc. All Rights Reserved.
//
//  Licensed under the MIT License (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      https://opensource.org/licenses/MIT
//
//  PurchasedProductsFetcher.swift
//
//  Created by Andrés Boedo on 3/17/23.

import Foundation
import StoreKit

protocol PurchasedProductsFetcherType {

    @available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.2, *)
    func fetchPurchasedProducts() async throws -> [PurchasedSK2Product]

}

/// A type that can fetch purchased products from StoreKit 2.
@available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12.0, *)
class PurchasedProductsFetcher: PurchasedProductsFetcherType {

    private let sandboxDetector: SandboxEnvironmentDetector

    init(sandboxDetector: SandboxEnvironmentDetector = BundleSandboxEnvironmentDetector()) {
        self.sandboxDetector = sandboxDetector
    }

    func fetchPurchasedProducts() async throws -> [PurchasedSK2Product] {
        var result: [PurchasedSK2Product] = []

        let syncError: Error?
        do {
            try await Self.forceSyncToEnsureAllTransactionsAreAccountedFor()
            syncError = nil
        } catch {
            syncError = error
        }

        for await transaction in StoreKit.Transaction.currentEntitlements {
            switch transaction {
            case let .unverified(unverifiedTransaction, verificationError):
                Logger.appleWarning(
                    Strings.offlineEntitlements.found_unverified_transactions_in_sk2(unverifiedTransaction,
                                                                                     verificationError)
                )
            case let .verified(verifiedTransaction):
                result.append(.init(from: verifiedTransaction,
                                    sandboxEnvironmentDetector: self.sandboxDetector))
            }
        }

        if result.isEmpty, let error = syncError {
            // Only throw errors when syncing with the store if there were no entitlements found
            throw error
        } else {
            // If there are any entitlements, ignore the error.
            return result
        }
    }

    private static func forceSyncToEnsureAllTransactionsAreAccountedFor() async throws {
        try await AppStore.sync()
    }

}

// MARK: -

/// An empty implementation of `PurchasedProductsFetcherType` for platforms
/// that don't support `PurchasedProductsFetcher`.
final class VoidPurchasedProductsFetcher: PurchasedProductsFetcherType {

    @available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.2, *)
    func fetchPurchasedProducts() async throws -> [PurchasedSK2Product] {
        assertionFailure("This should never be used")
        return []
    }

}
