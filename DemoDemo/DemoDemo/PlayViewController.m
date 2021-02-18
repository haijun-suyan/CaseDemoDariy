//
//  PlayViewController.m
//  DemoDemo
//  研究方向电子合成音
//  Created by haijunyan on 2020/11/19.
//  Copyright © 2020 haijunyan. All rights reserved.
//  

#import "PlayViewController.h"
#import <AVFoundation/AVSpeechSynthesis.h>


#define kScreenW [UIScreen mainScreen].bounds.size.width
@interface PlayViewController ()<AVSpeechSynthesizerDelegate>
@property(nonatomic,strong)UIButton *backBtn;
@property(nonatomic,strong)UILabel *labText;
@property(nonatomic,strong)UIButton *playBtn;
//语音合成器
@property(nonatomic,strong)AVSpeechSynthesizer *voice;
@property(nonatomic,strong)AVSpeechUtterance *speech;

@end

@implementation PlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self neededEmbedView];
    [self speechPrepare];

}

- (void)neededEmbedView {
    [self.view addSubview:self.backBtn];
    self.backBtn.frame = CGRectMake(20, 80, 70, 20);

    [self.view addSubview:self.labText];
    self.labText.frame = CGRectMake(20, 130, kScreenW, 50);

    [self.view addSubview:self.playBtn];
    self.playBtn.frame = CGRectMake(20, 200, 70, 20);
}

- (void)speechPrepare {
    self.voice = [AVSpeechSynthesizer new];
    self.voice.delegate = self;
    //待转换文字
    self.speech = [[AVSpeechUtterance alloc] initWithString:self.labText.text];
    //音调调节[0.5 - 2]
    self.speech.pitchMultiplier = 1;
    //音量调节[0-1]
    self.speech.volume = 1;
    //语速调节[0最慢-1最快]
    self.speech.rate = 0.5;
    //语种
    AVSpeechSynthesisVoice *language = [AVSpeechSynthesisVoice voiceWithLanguage:@"zh-CN"];
    self.speech.voice = language;

}

- (UIButton *)backBtn {
    if (!_backBtn) {
        _backBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        _backBtn.backgroundColor = [UIColor whiteColor];
        _backBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        _backBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        [_backBtn setTitle:@"返回" forState:UIControlStateNormal];
        [_backBtn setTitle:@"返回" forState:UIControlStateHighlighted];
        [_backBtn addTarget:self action:@selector(backBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}

- (void)backBtnClicked:(UIButton *)psender{
    [self dismissViewControllerAnimated:NO completion:^{}];
}

- (UILabel *)labText {
    if (!_labText) {
        _labText = [[UILabel alloc] init];
        _labText.backgroundColor = [UIColor cyanColor];
        _labText.textAlignment = NSTextAlignmentLeft;
        _labText.font = [UIFont systemFontOfSize:13];
        _labText.textColor = [UIColor blackColor];
        _labText.text = @"你好吗上海农商银行";
    }
    return _labText;
}

- (UIButton *)playBtn {
    if (!_playBtn) {
        _playBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        _playBtn.backgroundColor = [UIColor whiteColor];
        _playBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        _playBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_playBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_playBtn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        [_playBtn setTitle:@"播放" forState:UIControlStateNormal];
        [_playBtn setTitle:@"播放" forState:UIControlStateHighlighted];
        _playBtn.layer.cornerRadius = 10;
        _playBtn.layer.masksToBounds = YES;
        [_playBtn addTarget:self action:@selector(playBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playBtn;
}

- (void)playBtnClicked:(UIButton *)psender {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.voice speakUtterance:self.speech];//播放
    });

}

@end
