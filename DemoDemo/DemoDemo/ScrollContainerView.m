//
//  ScrollContainerView.m
//
//  Created by haijunyan on 2020/7/6.
//  Copyright © haijunyan. All rights reserved.
//

#import "ScrollContainerView.h"
@interface ScrollContainerView ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView *scrollView;
@end

@implementation ScrollContainerView
- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.scrollsToTop = NO;
        _scrollView.delegate = self;
        _scrollView.contentSize = CGSizeMake(0.0, 0.0);
        _scrollView.bounces = NO;
        _scrollView.scrollEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
        _scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        //提示用户Indicatorsflash
        [_scrollView flashScrollIndicators];
        _scrollView.directionalLockEnabled = YES;
    }
    return _scrollView;
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectZero];
        _contentView.backgroundColor = [UIColor whiteColor];
    }
    return _contentView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self neededEmbededView];
    }
    return self;
}

- (void)neededEmbededView {
    [self addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left);
        make.top.mas_equalTo(self.mas_top);
        make.right.mas_equalTo(self.mas_right);
        make.height.mas_equalTo(self.mas_height);
    }];

    [self.scrollView addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.scrollView.mas_left);
        make.top.mas_equalTo(self.scrollView.mas_top);
        make.right.mas_equalTo(self.scrollView.mas_right);
        make.bottom.mas_equalTo(self.scrollView.mas_bottom);
    }];
}

- (void)backGroundColorContainer:(UIColor *)color {
    self.scrollView.backgroundColor = color;
}

- (void)scrollsToBottom:(BOOL)animated {
    float offset = self.scrollView.contentSize.height-self.scrollView.bounds.size.height;
    if (offset>0) {
        [self.scrollView setContentOffset:CGPointMake(0, offset) animated:animated];
    }
}

#pragma mark ----- UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
}
@end
