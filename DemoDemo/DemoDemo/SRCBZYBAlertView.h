//
//  SRCBZYBAlertView.h
//  DemoDemo
//
//  Created by haijunyan on 2021/5/8.
//  Copyright © 2021 haijunyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SRCBZYBAlertView : UIView
@property(nonatomic,copy)void (^ElementClick)(NSInteger index,UIButton *btn);
+ (instancetype)shareInstance;
@end
