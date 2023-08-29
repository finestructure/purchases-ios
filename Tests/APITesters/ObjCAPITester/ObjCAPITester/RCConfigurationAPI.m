//
//  RCConfigurationAPI.m
//  ObjCAPITester
//
//  Created by Joshua Liebowitz on 5/6/22.
//

#import "RCConfigurationAPI.h"

@import RevenueCat;

@implementation RCConfigurationAPI

+ (void)checkAPI {
    RCConfigurationBuilder *builder = [RCConfiguration builderWithAPIKey:@""];
    RCConfiguration *config __unused = [[[[[[[[[[[[[builder withApiKey:@""]
                                                   withObserverMode:false]
                                                  withObserverMode:true storeKitVersion:RCConfigurationStoreKitVersionStoreKit1]
                                                 withUserDefaults:NSUserDefaults.standardUserDefaults]
                                                withAppUserID:@""]
                                               withAppUserID:nil]
                                              withDangerousSettings:[[RCDangerousSettings alloc] init]]
                                             withNetworkTimeout:1]
                                            withStoreKit1Timeout: 1]
                                           withPlatformInfo:[[RCPlatformInfo alloc] initWithFlavor:@"" version:@""]]
                                          withUsesStoreKit2IfAvailable:false]
                                         withStoreKitVersion:RCConfigurationStoreKitVersionStoreKit2]
                                        build];

    if (@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.2, *)) {
        RCConfiguration *config __unused = [[builder
                                             withEntitlementVerificationMode:RCEntitlementVerificationModeInformational]                                            build];
    }
}

+ (void)checkStoreKitVersion:(RCConfigurationStoreKitVersion)version {
    switch (version) {
        case RCConfigurationStoreKitVersionStoreKit1:
        case RCConfigurationStoreKitVersionStoreKit2:
            break;
    }
}

@end
