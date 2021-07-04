//  release:栈区字段名置nil的行为(主动/被动)
//  retain：堆内存区本身保留的稳定性状态标记retain(retain=0进入销毁启动的临界点/retain越大说明堆内存区越稳定)
//  dealloc：retain=0动作销毁阶段
//  AutoReleaseViewController.m
//  DemoDemo
//  正向因果(主动nil)：栈区字段名置空nil(释放)-> 实例本身堆内存区销毁
//  逆向因果(被动nil)：实例本身堆内存区销毁 -> 栈区字段名置空nil(释放)
//  逆向因果(被动nil)出现的典型例子是弱引用字段名(字段名弱化/weak字段名/字段名只单纯的拥有某个已存在堆内存区的入口地址但不会加强该地址对应堆内存区本身的稳定性(weak字段名不会加强/削弱/改变该地址对应堆内存区本身的稳定性(对应堆内存区本身的retain标记值不会增大/减小)))
//  Created by haijunyan on 2021/4/27.
//  Copyright © 2021 haijunyan. All rights reserved.
//  自动释放池环境管理栈名置nil效果的时机
//  AutoReleasePool(自动释放池环境(内存自动回收的管理机制))可延迟 在AutoReleasePool自动释放池环境管控下的栈名本身的置nil(释放)时机。
// 正常情况下创建某个变量栈名在离开变量栈名所在的有效作用域范围后变量栈名将置nil释放release，若将变量栈名绑定在某个AutoReleasePool自动释放池环境体系内则变量栈名的置nil释放release行为将被延迟至离开释放池环境临界时刻。

//  栈内存绑定监控着堆内存
//  字段名本身对应栈内存区域
//  字段名持有nil表示字段名本身对应的栈内存区域内写入持有的堆区地址为nil，这意味着不存在有效的实例堆内存区供字段名访问(但只要尚未离开字段名定义申明时对应的有效范围位置区域则字段名本身对应的栈内存区域本身依旧存在(只不过写入持有地址为nil))
//  1)栈区器皿本身直接不存在 2)栈区器皿本身存在但栈器皿内部存放的(堆)地址信息直接为nil
//  堆内存区本身的稳定性状态 量化标记retain
//  伴随某个堆内存区的开辟，在该堆内存区正式被开辟时伴随的量化标记retain正常情形取默认值为0，某些情形下可能默认为1(自动销毁受阻)
// CoreFoundation(C语言)/Foundation(OC语言)：2个层面存在2个不同类下2套不同API来访问和使用本已开辟出的已客观存在的RunLoop实例。
//  CoreFoundation:CFRunLoopRef(C语言)/Foundation:NSRunLoop (OC语言)
//  NSRunLoop类是基于CFRunLoopRef类进行OC层面包装,NSRunLoop类和CFRunLoopRef类字段名都可以接收RunLoop实例对象值。

//  二次封装类的概念
//  映射的概念：映射特征：查找的一步到位(字典案例)
//  数据体的概念(数据体系的概念)
//  指针型字段名遵循逆向传值的特征
//  Mode模态对象:广泛意义上的数据综合体
//  矢量差值分析状态
//  内容指令、自身状态指令
//  被观察的目标对象
//  👀观察者的响应回调事件
//  事件分类：响应回调事件(动作)、方向描述事件(描述(名称))、状态描述事件(描述(名称))
//

#import "AutoReleaseViewController.h"

@interface AutoReleaseViewController ()
{
    //申明weak弱化字段名(观察对象实例值对应堆内存区本身的存在销毁状态(稳定性))(弱化字段名不会更改弱化字段名所拥有的某个地址的堆内存区本身的稳定性)
    __weak NSString *weakString;
    __weak NSString *weakStringAutoRelease;
}

@end

@implementation AutoReleaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /****OC层面包装****/
//    CFArrayRef ary;
//    NSArray *aryNS;
//
//    CFStringRef string;
//    NSString *stringNS;
    /****OC层面包装****/
    //NSRunLoop是对CFRunLoopRef做OC层面包装,所以C语言获取的地址和OC层面获取的地址虽不同但实际依旧对应着同个RunLoop运行环路RL值.
//    //C语言
//    CFRunLoopRef runLoop = CFRunLoopGetCurrent();
//    CFRunLoopRef runLoopMain = CFRunLoopGetMain();
    //OC语言
    NSRunLoop *runLoopNS = [NSRunLoop currentRunLoop];
    NSRunLoop *runLoopMainNS = [NSRunLoop mainRunLoop];
//    NSLog(@"C=%p %p",runLoop,runLoopMain);
    NSLog(@"NSThread=%@",[NSThread currentThread]);
    NSLog(@"OC=RunLoop=%p %p",runLoopNS,runLoopMainNS);
    //运行环路的实际研究(推荐OC层面)
    //任何线程都会存在唯一匹配绑定映射的对应运行环路RunLoop对象值(一一对应映射绑定关系)
    //RunLoop保存在一个全局的Dictionary里,线程相关信息作为key键属性的数据,RunLoop对象值作为value结果值的内容数据。
    //线程本质也属于实例对象值(底层SDK内包含自动开辟指令(自动开辟某片堆内存区作为线程对象值(线程对象值初被开辟出来时次级字段名尚未持有有效的运行环路RL对象值/主线程：当应用中存在某个信号信息需要主线程正式处理时已开辟的主线程对象进入激活活跃状态将触发底层的主(运行)环路对象自动开辟指令，正式的自动开辟对应的主(运行)环路实例对象值，实施主环路的使用(绑定对应的线程)))),在线程对象结束销毁后运行环路RL值才会销毁。
    //主线程对应的主环路为底层自动的创建(底层存在[NSRunLoop currentRunLoop]自调用),子线程对象下需要手动去开辟运行环路RL值(子线程[NSRunLoop currentRunLoop]手动调用).
    //[NSRunLoop currentRunLoop]：类似Get函数懒加载
    //线程本身的对象值进入活跃状态与之绑定的对应环路切换进入活跃模式对应用的场景状态实施监控并处理信号信息。
    //指针型参数：对应栈区本身的入口地址
    //实例对象值本身堆内存区的回收称为销毁Dealloc/字段名本身栈内存区的回收称为释放Releease
    //RunLoop内部注入的数据结构(数据所遵循的结构特征)
    //
//    UIView *viewq = [UIView new];
//    viewq.backgroundColor = [UIColor colorWithHex:0x1ea7e8];
//    [self.view addSubview:viewq];
//    viewq.frame = CGRectMake(0, 100,100, 100);

//    CFRunLoopRef
//    CFRunLoopMode
//    CFRunLoopSourceRef
//    CFRunLoopTimerRef
//    CFRunLoopObserverRef
//RunLoop对象内有很多个模态但在每一个特定的时刻下有且仅有某1个模态匹配_currentMode字段。
    //RunLoop对象内存在dowhile循环体,不断的循环捕获应用程序中出现的数据信号(时刻监视每个Mode模态对象的状态并处理Mode模态对象内Source0、Source1、Timer、Observer事件)。
    //??????????
    

    




    //全新上下文环境+指令组合
//    @autoreleasepool {
//
//        NSString *string = [[NSString alloc] initWithFormat:@"Hello, World!"];//创建常规对象
//        weakString = string;
//        NSLog(@"------in the createString()------");
//        NSLog(@"%@", weakString);
//        NSLog(@"------in the autoreleasepool------");
//        NSLog(@"%@", weakString);
//
//    }

    //内存空间的浪费/内存的泄漏遗失
//    for (int i=0;i<10000000;i++) {
//
//        UIImage *imageSSS = [UIImage imageNamed:@"pic"];
//    }

//    NSLog(@"------in the main()------");
//    NSLog(@"%@", weakString);

//    NSLog(@"%@\n\n", weakStringAutoRelease);

//    NSLog(@"------in the main()------");
//    NSLog(@"%@", weak_String);
//    NSLog(@"%@", weak_StringAutorelease);

//    [self memoryDeallocAutoRelease];
//    NSLog(@"------in the main()------");
//    NSLog(@"%@",weakString);
}


//1->0 销毁
- (void)creatString {
    NSString *string = [[NSString alloc] initWithFormat:@"Hello, World!"];    // 创建常规对象
    weakString = string;
    NSLog(@"------in the createString()------");
    NSLog(@"%@", weakString);
}

- (void)memoryAnalisis {
    NSString *stringAutorelease = [NSString stringWithFormat:@"Hello, World! Autorelease"]; // 创建autorelease对象
    weakStringAutoRelease = stringAutorelease;
    NSLog(@"------in the memoryAnalisis()------");
    NSLog(@"%@\n\n", weakStringAutoRelease);
}

- (void)memoryDealloc {
    //@"abc" :堆内存自动销毁受阻
    NSString *str = @"abc";
    weakString = str;
    NSLog(@"------in the memoryDealloc()------");
    NSLog(@"%@",weakString);
    NSLog(@"%@",str);
}


- (void)memoryDeallocAutoRelease {
    @autoreleasepool {
        //@"abcd" :堆内存自动销毁受阻
        NSString *str = @"abcd";
        weakString = str;
        NSLog(@"------in the memoryDeallocAutoRelease()------");
        NSLog(@"%@",weakString);
        NSLog(@"%@",str);
    }

//    //@"abcd" :堆内存自动销毁受阻
//    NSString *str = @"abcd";
//    weakString = str;
//    NSLog(@"------in the memoryDeallocAutoRelease()------");
//    NSLog(@"%@",weakString);
//    NSLog(@"%@",str);

}
//队列->线程->环路->模态
//backtrace:bt异常追踪回溯(回溯堆栈)
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"func=%s",__func__);
}

/*模态内Source0规则体底层调用：触摸操作的响应事件、performSelector:onThread:
 *模态内Source1规则体底层调用:基于端口Port之线程间的通信、系统事件的捕捉(多线程之间相互传递消息的处理、系统事件捕捉(包括触摸的操作事件(捕捉触摸事件再传递给Source0))).
 *模态内Timer规则体底层调用:NSTimer定时器、performSelector:withObject:afterDelay(afterDelay方法的底层实现是NSTimer实现)
 *模态内Observers规则体底层调用:监听RunLoop对象所处状态(若Loop对象进入Wait休眠期),触动UI刷新/AutoRelease pool(BeforeWaiting)(RunLoop对象休眠前定会执行完UI刷新(如设置背景色,frame布局等)、AutoReleasepool释放等)。
 */

/*
 *
 *
 *
 *
 *
 */

- (void)testDescription {
    NSLog(@"testDescriptionNoumenon");
}

@end

