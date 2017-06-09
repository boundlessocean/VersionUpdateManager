//
//  MFAPPVersionTool.m
//  MyFreeMall
//
//  Created by boundlessocean on 16/9/2.
//  Copyright © 2016年 GXCloud. All rights reserved.
//

#import "BLAPPVersionManager.h"

@implementation BLAPPVersionManager


+ (void)checkAppInfoInAppStoreWithAppID:(NSString *)AppID
                              InfoBlock:(void (^)(BLAPPInfoModel * _Nonnull))infoBlock{
    
    // URL
    NSString *APPAddressString = [NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%@",AppID];
    NSURL *APPAddressURL = [[NSURL alloc] initWithString:APPAddressString];
    
    // session
    NSURLSession *sessionManager = [NSURLSession sharedSession];
    sessionManager.configuration.timeoutIntervalForRequest = 20;
    sessionManager.configuration.timeoutIntervalForResource = 20;
    
    // task
    NSURLSessionTask *task =
    [sessionManager dataTaskWithURL:APPAddressURL
                  completionHandler:^(NSData * _Nullable data,
                                      NSURLResponse * _Nullable response,
                                      NSError * _Nullable error) {
                      if (data) {
                          NSDictionary *infoData = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                          if (infoData) {
                              NSDictionary *AppInfo = infoData[@"results"][0];
                              
                              BLAPPInfoModel *model = [BLAPPInfoModel new];
                              model.releaseNotes = AppInfo[@"releaseNotes"];
                              model.version = AppInfo[@"version"];
                              model.trackViewUrl = AppInfo[@"trackViewUrl"];
                              infoBlock(model);
                          }
                      }
                  }];
    
    // resume
    [task resume];
}
@end

@implementation BLAPPInfoModel

- (void)setReleaseNotes:(NSString *)releaseNotes{
    _releaseNotes = releaseNotes ? releaseNotes : @"\n发现新版本" ;
}

- (void)setVersion:(NSString *)version{
    _version = version;
    
    NSComparisonResult result = [self compareAppVersion:_version];
    _isNeedUpdate = result == NSOrderedAscending ? YES : NO;
}


/**
 本地version 和 appstore version比较

 @param appStoreVersion App Store 版本
 @return 比较结果
 */
- (NSComparisonResult)compareAppVersion:(NSString *)appStoreVersion{
    // 本地 Version
    NSString *AppShortVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString *AppBuild = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    NSString *localVersion = [AppShortVersion stringByAppendingString: [NSString stringWithFormat:@".%@",AppBuild]];
    
    return [localVersion compare:appStoreVersion];
}


@end


