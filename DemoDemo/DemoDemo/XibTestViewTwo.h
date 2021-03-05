//
//  XibTestViewTwo.h
//  DemoDemo
//
//  Created by haijunyan on 2021/2/25.
//  Copyright © 2021 haijunyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XibTestViewTwo : UIView
@property(nonatomic,copy)void (^BtnClick)(void);
+ (instancetype)shareInstance;
@end
