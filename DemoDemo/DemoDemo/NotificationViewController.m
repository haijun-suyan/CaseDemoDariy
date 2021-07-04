//  线程池里面存在很多个线程对象但实际参与使用的线程对象则是有限个
//  NotificationViewController.m
//  DemoDemo
//  GCD逻辑的本质是不同线程间切换的表象并非线程的本身。
//  Created by haijunyan on 2021/7/1.
//  Copyright © 2021 haijunyan. All rights reserved.
//  name:关于某方面的通知信号
//  不同线程里面的任务不好确定顺序先后

//  监听者(添加)指令所在线程
//  接收通知线程：绑定事件所在的目标线程
//  (Post)发出通知(指令)线程：通知事件Post发出(位置)指令所在线程
//  通知的发出与接收必然处于同一个线程中，与注册监听者所在的线程无关
//  注册监听者所在线程随意(一般习惯于在主线程注册监听)，对通知的发出和接收本身没有影响
//通知信号主线程发出则主线程接收/通知信号x子线程发出则x子线程接收，无论什么线程信号本身都可以顺利实现传输(关注点在于界面UI刷新直接相关指令强制主线程执行否则异常失效)

#import "NotificationViewController.h"
#define CurThread [NSThread currentThread]
#define DefaultCenter [NSNotificationCenter defaultCenter]

@interface NotificationViewController ()
@property (weak, nonatomic) IBOutlet UILabel *testL;

@end

@implementation NotificationViewController

//- (void)viewDidLoad {
//    [super viewDidLoad];
//    //关键2:通知事件的(注册)监听者添加指令(位置)
//    //监听者发出命令信号(让目标线程执行相关绑定事件)
//    NSLog(@"Th=%@",CurThread);
//    [DefaultCenter addObserver:self selector:@selector(receive) name:@"testNoti" object:nil];
//
//}
//
////系统API事件(触摸自调用系统事件)
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    NSLog(@"1");
//
//    //创建普通队列串行
//    dispatch_queue_t serialQueue = dispatch_queue_create("串行", DISPATCH_QUEUE_SERIAL);
//    dispatch_async(serialQueue, ^{
//        NSLog(@"Thread=%@",CurThread);
//        //关键1:通知事件Post发出(位置)
//        [DefaultCenter postNotificationName:@"testNoti" object:nil];
//    });
//
//    NSLog(@"2");
//
//}
//
////关键3:目标线程下默认执行的绑定事件
//- (void)receive {
//    NSLog(@"ReceiveThread=%@",CurThread);
//    dispatch_async(dispatch_get_main_queue(), ^{
//        self.testL.text = @"王乐乐";
//    });
//}


//- (void)viewDidLoad {
//    [super viewDidLoad];
//
//    //创建队列全局并行
//    dispatch_queue_t globalConcurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_async(globalConcurrentQueue, ^{
//        //关键2:通知事件的(注册)监听者添加指令(位置)
//        //监听者发出命令信号(让目标线程执行相关绑定事件)
//        NSLog(@"globalTh=%@",CurThread);
//        [DefaultCenter addObserver:self selector:@selector(receive) name:@"testNoti" object:nil];
//    });
//
//}
//
////系统API事件(触摸自调用系统事件)
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    NSLog(@"1");
//
//    //创建普通队列串行
//    dispatch_queue_t serialQueue = dispatch_queue_create("串行", DISPATCH_QUEUE_CONCURRENT);
//    dispatch_async(serialQueue, ^{
//        NSLog(@"Thread=%@",CurThread);
//        //关键1:通知事件Post发出(位置)
//        [DefaultCenter postNotificationName:@"testNoti" object:nil];
//    });
//
//    NSLog(@"2");
//
//}
//
////关键3:目标线程下默认执行的绑定事件
//- (void)receive {
//    NSLog(@"ReceiveThread=%@",CurThread);
//
//    dispatch_async(dispatch_get_main_queue(), ^{
//        self.testL.text = @"王乐乐";
//    });
//}


//- (void)viewDidLoad {
//    [super viewDidLoad];
//    //关键2:通知事件的(注册)监听者添加指令(位置)
//    //监听者发出命令信号(让目标线程执行相关绑定事件)
//    NSLog(@"globalTh=%@",CurThread);
//    [DefaultCenter addObserver:self selector:@selector(receive) name:@"testNoti" object:nil];
//}
//
////系统API事件(触摸自调用系统事件)
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    NSLog(@"1");
//
//    NSLog(@"Thread=%@",CurThread);
//    //关键1:通知事件Post发出(位置)
//    [DefaultCenter postNotificationName:@"testNoti" object:nil];
//
//    NSLog(@"2");
//
//}
//
////关键3:目标线程下默认执行的绑定事件
//- (void)receive {
//    NSLog(@"ReceiveThread=%@",CurThread);
//
//    self.testL.text = @"王乐乐";
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建队列全局并行
    dispatch_queue_t globalConcurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(globalConcurrentQueue, ^{
        //关键2:通知事件的(注册)监听者添加指令(位置)
        //监听者发出命令信号(让目标线程执行相关绑定事件)
        NSLog(@"globalTh=%@",CurThread);
        [DefaultCenter addObserver:self selector:@selector(receive) name:@"testNoti" object:nil];
    });
}

//系统API事件(触摸自调用系统事件)
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"1");

    NSLog(@"Thread=%@",CurThread);
    //关键1:通知事件Post发出(位置)
    [DefaultCenter postNotificationName:@"testNoti" object:nil];

    NSLog(@"2");

}

//关键3:目标线程下默认执行的绑定事件
- (void)receive {
    NSLog(@"ReceiveThread=%@",CurThread);
    self.testL.text = @"王乐乐";
}











@end
