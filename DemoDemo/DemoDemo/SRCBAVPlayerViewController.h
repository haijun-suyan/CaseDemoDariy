//
//  SRCBAVPlayerViewController.h
//  SRCBBank
//
//  Created by wlz on 2021/4/28.
//  Copyright © 2021 李培辉. All rights reserved.
//

NS_ASSUME_NONNULL_BEGIN

@interface SRCBAVPlayerViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *sssss;

@property (weak, nonatomic) IBOutlet UILabel *testLabel;

@property (nonatomic, strong) NSString *videoUrl;

@property (nonatomic, copy) NSString *introduceText;

@property (nonatomic, strong) NSDictionary *paramDict;

@property (nonatomic, copy) void (^callBackBlock)(void);

@end

NS_ASSUME_NONNULL_END
