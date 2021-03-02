//
//  ScrollContainerView.h
//
//  Created by haijunyan on 2020/7/6.
//  Copyright © 2020 haijunyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
@interface ScrollContainerView : UIView
@property(nonatomic,strong)UIView *contentView;
- (void)backGroundColorContainer:(UIColor *)color;
@end
