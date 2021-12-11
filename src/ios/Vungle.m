#import <Cordova/CDV.h>
#import "Vungle.h"

#import <VungleSDK/VungleSDK.h>
#import <VungleAdapter/VungleAdapter.h>
#import <VungleAdapter/VungleAdNetworkExtras.h>

#import <GoogleMobileAds/GADExtras.h>
#import <GoogleMobileAds/GADRewardedAd.h>

@implementation VunglePlugin

- (void)pluginInitialize {
    [super pluginInitialize];
    if (self) {
        NSDictionary* settings = self.commandDelegate.settings;
        NSString* bannerId = settings[@"BANNER_ID"];
        NSString* interstitialId = settings[@"INTERSTITIAL_ID"];
        NSString* rewardedId = settings[@"REWARDED_ID"];
        NSLog(@"Vungle mediation plugin init");

        GADRequest *request = [GADRequest request];
        VungleAdNetworkExtras *extras = [[VungleAdNetworkExtras alloc] init];

        NSMutableArray *placements = [[NSMutableArray alloc]initWithObjects:bannerId, interstitialId, rewardedId, nil];
        extras.allPlacements = placements;
        [request registerAdNetworkExtras:extras];
        [_interstitial loadRequest:request];

        [GADRewardedAd
            loadWithAdUnitID:rewardedId
            request:request
            completionHandler:^(GADRewardedAd *ad, NSError *error) {
                NSLog(@"load handler");
            }
        ];
    }
} @end
