//  元组件本身默认方形矩形区域
//  OptimizationViewController.m
//  DemoDemo
//  正向因果：栈区字段名置空nil(释放)-> 实例本身堆内存区销毁
//  逆向因果：实例本身堆内存区销毁 -> 栈区字段名置空nil(释放)
//  Created by haijunyan on 2021/4/22.
//  Copyright © 2021 haijunyan. All rights reserved.
//  自动释放池环境管理栈名置nil效果时机


#import "OptimizationViewController.h"
#import "UIImageView+Corner.h"

@interface OptimizationViewController ()
@property(nonatomic,strong)UIImageView *imgV;
@end

@implementation OptimizationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imgV = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    self.imgV.image = [UIImage imageNamed:@"testicon"];
    [self.view addSubview:self.imgV];
    [UIImageView shadowUI:self.imgV];

    

}

@end
