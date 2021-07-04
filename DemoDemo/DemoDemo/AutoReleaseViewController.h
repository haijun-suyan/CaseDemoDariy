//
//  AutoReleaseViewController.h
//  DemoDemo
//
//  Created by haijunyan on 2021/4/27.
//  Copyright © 2021 haijunyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AutoReleaseViewController : UIViewController
@property(nonatomic,copy)void (^SSS)(NSString *name);
- (void)testDescription;
@end
