//
//  main.m
//  DemoDemo
//
//  Created by haijunyan on 2020/11/19.
//  Copyright © 2020 haijunyan. All rights reserved.
//  clang/gcc基于llvm框架搭建
//  main()事件不受主loop环路下自动构建的自动释放池双向链表的映射管理
//main()事件内部需要手工构建新的自动释放池双向链表block区(iOS整个应用程序都包含在一个自动释放池block中。)
//A环境自动释放池对应的A释放时机/B环境自动释放池对应的B释放时机/不同方式衍生出的自动释放池环境对应着不同的释放时机
//  SDK更底层存在运行回环的机制对象(实例对象：具有回环效果)
//  UIApplicationMain事件:用户主程序入口事件(事件函数本身实例的更底层包含遵循着UIApplicationDelegate辅助代理协议的applicationDelegate字段名)
//  领导类leader
//  UIApplicationMain事件:开辟RunLoop运行环路RL实例值.(开辟动作) 应用icon图标点击start启动->main文件触发入口main函数事件->UIApplicationMain事件->AppDelegate->渲染的管理窗口window->UIViewController普通vc渲染
//  肉眼可见可修改的指令码称为手动代码
//  肉眼不可见不可修改的指令码称为自动代码
#import "AppDelegate.h"
//#import <objc/runtime.h>
//#import <sys/time.h>
//#include <sys/time.h>


//int main(int argc, char * argv[]) {
//    return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
//}

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}

//int main(int argc, char * argv[]) {
//
//    @autoreleasepool {
//        NSString *app = @"App";
//        [app stringByAppendingString:@"-Suffix"];
//    }
//
//    return 0;
//}


//应用icon图标点击start启动->main文件触发入口main函数事件->
//int main(int argc, char * argv[]) {
//    @autoreleasepool {
//        NSLog(@"Hello,World!");
//    }
//    //sleep休眠模式下程序依旧是活着的(逻辑还在延续着  )
//    //UIApplicationMain事件遗失(逻辑无法继续往后延伸,无法激活用户主程序入口(主程序入口下理应开辟的RunLoop运行回环实例值没有开辟此前提下不存在RunLoop运行回环实例值(休眠/活跃必然不存在研究意义())))
//    //主程序执行完return0后从逻辑层面来说无法继续往后延伸,无法激活用户主程序入口(主程序入口下理应开辟的RunLoop运行环路实例值没有开辟出来即无法通过已开辟出的RunLoop运行环路实例值机制实现对用户程序状态的监控即在更底层缺少RunLoop运行环路实例对象值监控机制的情形下逻辑无法继续(CPU不再活跃),程序会自动退出
//    return 0;
//}

//int main(int argc, char * argv[]) {
//    int retVal = 0;
//    do {
//        NSLog(@"Hello,World!");
//    } while (retVal == 0);
//
//    return 0;
//}

//int main(int argc, char * argv[]) {
//    @autoreleasepool {
//        int retVal = 0;
//        do {
//            NSLog(@"Hello,World!");
//        } while (retVal == 0);
//    }
//    return 0;
//}

//窗口window层出现信号操作事件待处理触发process_message函数事件
//RunLoop本质：只要retVal字段名对应数据0则dowhile循环一直持续下去逻辑不断的延伸,应用程序依旧会一直执行而不退出。 若没有捕获到信号事件待处理时RunLoop运行环路会进入低耗sleep休眠状态节省CPU资源,当窗口内出现某个信号事件待处理就调用process_message函数由CPU去处理对应信号事件,在信号事件处理完成后即没有一般性(CPU消耗)的普通信号事件待处理则继续进入低耗sleep休眠状态
//低耗2层含义：1)消耗虽极其低但依旧还是存在着消耗的即程序依旧在持续运行着 2)对CPU消耗低即休眠状态节省CPU资源、降低占用率、增加CPU可用活性、提高程序执行性能。
//(3)当窗口内出现某个信号事件待处理就调用process_message函数由CPU去处理对应信号事件(处理App窗口内各种信号事件(比如触摸信号事件、定时器信号事件、PerformSelector执行封盒选择器信号事件、GCDAsyncMainQueue信号事件、手势信号事件、界面刷新信号事件、网络请求信号事件、AutoreieasePool信号事件等))
//int main(int argc, char * argv[]) {
//    @autoreleasepool {
//
//        /***RunLoop底层等效伪代码Start***/
////        int retVal = 0;
////        do {
////            //休眠中等待信号📶
////            int message = sleep_and_wait();
////            //等待信号处理
////            retVal = process_message(message);
////            NSLog(@"Hello,World!");
////        } while (retVal == 0);
//        /***RunLoop底层等效伪代码End***/
//
//    }
//    //sleep休眠模式下程序依旧是活着的(CPU依旧活跃)(逻辑在延续)
//    return 0;
//}


