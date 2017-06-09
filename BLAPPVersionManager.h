//
//  MFAPPVersionTool.h
//  MyFreeMall
//
//  Created by boundlessocean on 16/9/2.
//  Copyright © 2016年 GXCloud. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BLAPPInfoModel;
@interface BLAPPVersionManager : NSObject

/**
 从App Store中查询app信息

 @param AppID app ID
 @param infoBlock 获取信息回调
 */
+ (void)checkAppInfoInAppStoreWithAppID:(NSString * _Nonnull)AppID
                              InfoBlock:(void(^ _Nullable)(BLAPPInfoModel * _Nonnull infoModel))infoBlock;
@end


@interface BLAPPInfoModel : NSObject

NS_ASSUME_NONNULL_BEGIN
/* 更新说明 */
@property (nonatomic, strong, null_resettable) NSString *releaseNotes;
/* 版本 */
@property (nonatomic, strong, nullable) NSString *version;
/* AppStore 地址 */
@property (nonatomic, strong) NSString *trackViewUrl;
/* 是否需要更新 */
@property (nonatomic, assign) BOOL isNeedUpdate ;

NS_ASSUME_NONNULL_END
@end
