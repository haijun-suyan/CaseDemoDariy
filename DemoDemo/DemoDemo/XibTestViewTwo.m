//
//  XibTestViewTwo.m
//  DemoDemo
//  不需自定义绘图则注释掉drawRect:事件
//  Created by haijunyan on 2021/2/25.
//  Copyright © 2021 haijunyan. All rights reserved.
//

#import "XibTestViewTwo.h"

@interface XibTestViewTwo ()

@end

@implementation XibTestViewTwo


+ (instancetype)shareInstance
{
    NSArray *elementsLt = [[NSBundle mainBundle] loadNibNamed:@"XibTestViewTwo" owner:self options:nil];
//    NSLog(@"elementsLt=%@",elementsLt);
    return [elementsLt firstObject];
}

- (IBAction)testBtnClicked:(id)sender {
    NSLog(@"testBtnClicked");
}

- (void)layoutSubviews {
    [super layoutSubviews];
    NSLog(@"layoutSubviewslayoutSubviews");
}

//自定义绘图(事件重写)
//空实现对动画性能产生不利影响
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    NSLog(@"drawRectXibTwo");
}

@end
