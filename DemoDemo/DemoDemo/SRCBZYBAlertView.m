//
//  SRCBZYBAlertView.m
//  DemoDemo
//
//  Created by haijunyan on 2021/5/8.
//  Copyright © 2021 haijunyan. All rights reserved.
//

#import "SRCBZYBAlertView.h"

@interface SRCBZYBAlertView ()

@end

@implementation SRCBZYBAlertView
+ (instancetype)shareInstance
{
    NSArray *elementsLt = [[NSBundle mainBundle] loadNibNamed:@"SRCBZYBAlertView" owner:self options:nil];
    return [elementsLt firstObject];
}

- (IBAction)cancelBtnClicked:(id)sender {//再等等0
    if (self.ElementClick) {
        self.ElementClick(((UIButton *)sender).tag,(UIButton *)sender);
    }
}

- (IBAction)okBtnClicked:(id)sender {//前往1
    if (self.ElementClick) {
        self.ElementClick(((UIButton *)sender).tag,(UIButton *)sender);
    }
}

- (IBAction)mainBtnClicked:(id)sender {//不在提示2
    if (self.ElementClick) {
        self.ElementClick(((UIButton *)sender).tag,(UIButton *)sender);
    }
}


@end
