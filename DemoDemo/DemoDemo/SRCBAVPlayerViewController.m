//
//  SRCBAVPlayerViewController.m
//  SRCBBank
//
//  Created by wlz on 2021/4/28.
//  Copyright © 2021 李培辉. All rights reserved.
//

#import "SRCBAVPlayerViewController.h"



@interface SRCBAVPlayerViewController ()


@end

@implementation SRCBAVPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.introduceText = @"222222";
}

- (void)setIntroduceText:(NSString *)introduceText
{
    _introduceText = introduceText;
    self.sssss.text = @"22222222";
    self.testLabel.text = @"22222222";
}

- (IBAction)sureBtnClick:(id)sender
{
    if (self.callBackBlock) {
        self.callBackBlock();
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
