//  IntrinsicContentSize内在内容大小
//  sizetofit尺寸匹配
//  ViewController.m
//  DemoDemo
//  域本身的实例值self
//  Created by haijunyan on 2020/11/19.
//  Copyright © 2020 haijunyan. All rights reserved.
//

#import "ViewController.h"
#import "ResponderChainViewController.h"
//runtime.h文件属于非公开文件(文件引入不会自动弹出/手动强制写入)
#import <objc/runtime.h>

#import "Dog.h"
#import "XibTestView.h"
#import "XibTestViewTwo.h"
#import "SRCBZYBAlertView.h"
#import "ScrollContainerView.h"
#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height

@interface ViewController ()
//链接渲染
@property(nonatomic,strong)CADisplayLink *displayLink;
@property(nonatomic,assign)double beginTime;
@property(nonatomic,assign)int count;
@property (weak, nonatomic) IBOutlet UILabel *oneL;

@property (weak, nonatomic) IBOutlet UILabel *twoL;
@property (weak, nonatomic) IBOutlet UIButton*threeBtn;

@property(nonatomic,strong)ScrollContainerView *containerView;
@property(nonatomic,strong)UIView *contentV;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self xibConstraints];
//    [self neededEmbedView];
//    [self displayLinkInstance];
//    [self runTimeAnalysis];
//    [self propertyType];
//    [self copyMethodList];
//    [self loadMethod];
//    [self associatedObjectsMethodNew];

//    NSString *base64 = [self base64StringFromText:@"王乐乐颜海军"];
//    [self pdfFromBase64String:@"q7crlVwnez4eq4qY5YB9kWIFq+IYROX1pq6+1J0p0GM4ZJjH318CuRGyhw3kSSUUlLkWVtPhkja6OihnoOQRz56Coe2Uq9eUkCeqadvOVJLdCmB2VE85rcyWZY2jY"];

//    NSFileManager *fm = [NSFileManager defaultManager];
//    NSData *data = [[NSData alloc] init];
//    data = [fm contentsAtPath:@"/Users/haijunyan/Library/Developer/CoreSimulator/Devices/D8E6FD9A-CE99-4F23-8B2C-B04A99A71B96/data/Containers/Data/Application/38478210-4AD7-418E-BED3-C4DE0B6E75AA/Documents/20201202221836Share.pdf"];
//    NSLog(@"桌面:%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);

//    NSError * error = nil;
//    //第三种方法： NSString类方法读取内容
//    NSString* content = [NSString stringWithContentsOfFile:@"/Users/haijunyan/Library/Developer/CoreSimulator/Devices/D8E6FD9A-CE99-4F23-8B2C-B04A99A71B96/data/Containers/Data/Application/6A23861B-5EF7-406B-9DFC-1C268026F62A/Documents/20201202220221Share.pdf" encoding:NSUTF8StringEncoding error:&error];
//    NSLog(@"NSString类方法读取的内容是：\n%@\n%@",content,error);

//    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDesktopDirectory, NSUserDomainMask, YES);
//    NSString* thepath = [paths lastObject];
//    thepath = [thepath stringByAppendingPathComponent:@"123.txt"];

    //第四种方法NSFileHandle实例方法读取内容
//    NSFileHandle *fh = [NSFileHandle fileHandleForReadingAtPath:@"/Users/haijunyan/Desktop/RuntimeDemo/DemoDemo/123.txt"];
//    NSData *data = [[NSData alloc] init];
//    data = [fh readDataToEndOfFile];
//    NSLog(@"NSFileHandle实例读取的内容是：\n%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);

//    NSError * error = nil;
//    //通过指定路径读取//函形参特征NSError * *(即函形参为指针结构可持有写入  NSError *结构对应的字段名的地址即&error(将事件函数的IMP执行体中底层指令捕获涉及的NSError错误信息数据逆向存入上层变量名(供分析调用)))
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"身体待处理问题" ofType:@"txt"];
//    NSString *str = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
//    //此时字段名error持有相关待研究的错误数据信息
//    NSLog(@"srt=%@",str);



}

- (void)testName:(NSString *)name {
    NSLog(@"xcode");
}

- (void)testHeight:(NSString *)height {
    
}



- (void)displayLinkInstance {
    //底层自动触发型指令调用(系统底层调用指令处一般默认进行所在类的对象实例值写入)
    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkTick:)];
    [_displayLink setPaused:NO];//触发displayLinkTick事件函数生效
    [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

//该事件函数的执行频率跟当前屏幕的刷新频率是一样的(1秒时长执行的次数就是当前的FPS值)
- (void)displayLinkTick:(CADisplayLink *)link {
    //初始化屏幕渲染的时间点
    if (_beginTime == 0) {
        _beginTime = link.timestamp;
        return;
    }
    //刷新次数累加
    _count++;
    //当前屏幕渲染的时间点与初始屏幕渲染的时间点差
    NSTimeInterval interval = link.timestamp - _beginTime;
    if (interval < 1) {
        //不足1秒，继续统计刷新次数
        return;
    }
    //刷新频率
    float fps = _count/interval;
    NSLog(@"fps=%.1f",fps);

    //1秒之后，初始化时间和次数，重新开始监测
    _beginTime = link.timestamp;
    _count = 0;
}




- (void)neededEmbedView {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 100, 200, 50)];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor orangeColor];
    label.font = [UIFont systemFontOfSize:15];
    label.text = @"你好吗，中国人！";
    [self.view addSubview:label];

}

- (ScrollContainerView *)containerView {
    if (!_containerView) {
        _containerView = [[ScrollContainerView alloc] init];
        [_containerView backGroundColorContainer:[UIColor whiteColor]];
    }
    return _containerView;
}

- (UIView *)contentV{
    if (!_contentV) {
        _contentV = [[UIView alloc] init];
        _contentV.backgroundColor = [UIColor whiteColor];
    }
    return _contentV;
}

- (void)runTimeAnalysis {
    u_int count = 0;
//    //C语法风格
//    struct objc_ivar * *ivars = class_copyIvarList([UIView class], &count);
    //unsigned int * _Nullable outCount:函形参outCount接收unsignedint内容区的地址(指针函形参outCount可以持有unsignedint内容区的地址(指针形参outCount对应的底层指令可以实现对相应内存区域的访问修改写入新数据值))
    //class_copyIvarList函数获取的列表中元素的数目通过底层的指针访问指令写入count对应的空间内(count对应区域内存放有元素的数目数据)
    //C语言体系C语法定义声明ivars数组
    Ivar* ivars = class_copyIvarList([UIView class], &count);
    for (int i = 0; i<count; i++) {
        //C语言ivar_getName函数事件：获取ivar地址指针对应的实例变量名
        const char *ivarName = ivar_getName(ivars[i]);
        NSString *ivarNameNS = [NSString stringWithCString:ivarName encoding:NSUTF8StringEncoding];
        NSLog(@"ivarNameNS=%@",ivarNameNS);
    }
}

- (void)propertyType {
    u_int count = 0;
    struct objc_property * *properties = class_copyPropertyList([UIView class], &count);
    for (int i = 0; i<count; i++) {
        const char *propertyName = property_getName(properties[i]);
        NSString *propertyNameNS = [NSString stringWithCString:propertyName encoding:NSUTF8StringEncoding];
        NSLog(@"propertyNameNS=%@",propertyNameNS);
    }
    free(properties);
}

- (void)copyMethodList {
    //方法事件细分2部分：方法事件名(形参规则)部分+执行体部分
    int a = 3;
    int *p = &a;//字段名p持有&a(变量a域地址)

    u_int count = 0;
    //获取所有方法(别名Method层次带有容器特性)
    //从内存的角度而言，methods为指针型符号变量(直接持有指针地址),methods持有的指针地址对应的内存域中存放的元素为Method结构特征型值
//    Method *methods = class_copyMethodList([UIView class], &count);
    //method列表(元素method)
    struct objc_method * *methods = class_copyMethodList([UIView class], &count);
    for (int i = 0; i<count; i++) {
        Method method = methods[i];
        //方法(方法事件名(形参规则)部分)类型风格是SEL选择器风格类型
        //T:C语法体系
        //名称信息以SEL风格类型存在
        SEL methodName = method_getName(method);
        NSString *methodNameStr = [NSString stringWithCString:sel_getName(methodName) encoding:NSUTF8StringEncoding];
        int arguments = method_getNumberOfArguments(method);
        NSLog(@"methodNameStr[%@],argumentsCNT=%d",methodNameStr,arguments);
    }
    //调用C库函数void free(void *)释放之前调用calloc、malloc或 realloc函数所申请的内存空间。
    free(methods);
}

- (void)loadMethod {
    //方法事件名(形参规则)部分+当前执行体部分(IMP)
    Method origin = class_getInstanceMethod([UIView class], @selector(touchesBegan:withEvent:));
    Method custom = class_getInstanceMethod([UIView class], @selector(custom_touchesBegan:withEvent:));
    //交换生效C库函数生效(origin/custom对应客观有效的IMP(新增/继承))
    method_exchangeImplementations(origin, custom);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

//UIViewController
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {


}

//实例对象值字符串(外围对象)和实例对象值数组做关联(核心对象)
- (void)associatedObjectsMethod {
    //事件方法/事件函数的行参可以接受某种地址值&(XX)则底层行参遵循结构特征typeof(XX) *指针型符号(作用:在事件方法/事件函数本身的执行体内对XX符号赋有效值)
//    static char * p = &overviewKey;//void *-子类->char * 多态概念
    //关联体系核心对象
    NSArray *array = [[NSArray alloc] initWithObjects:@"1", @"2", @"3", nil];
    //initWithFormat确保字符串可被销毁
    //关联体系外围对象
    NSString *overview = [[NSString alloc] initWithFormat:@"%@",@"first ThreeNumbers"];
    //关联关键字(当前关联体系下的hash映射键)
    static char overviewKey;
    //OBJC_ASSOCIATION_RETAIN数组array要保有相关联的对象.
    //正式搭建某个关联体系(hash映射键底层写入)
    objc_setAssociatedObject(array, &overviewKey, overview, OBJC_ASSOCIATION_RETAIN);
    //当overview手动释放(overview = nil名栈内存释放掉(正常情况下，overview名栈内存释放掉对应的内容堆内存不被持有也将销毁))时，由于关联策略指明了让数组array栈内存名通过策略方式对overview名栈内存原本持有的内容堆内存进行持有(此处index式持有)即overview名栈内存原本持有的内容堆内存依旧被等效字段名持有故相应的内容堆内存不会被销毁依旧存在。只有当数组array栈内存名也释放(array = nil)时相应的内容堆内存才会被销毁。
    //读取外围对象(核心对象/hash映射键)
    NSString *associatedOutObject = (NSString *)objc_getAssociatedObject(array,&overviewKey);
    NSLog(@"associatedOutObject=%@",associatedOutObject);

    //断开某个关联体系(外围对象位置nil/hash映射键底层读取)//断开关联策略随意配置
    objc_setAssociatedObject(array,&overviewKey,nil, OBJC_ASSOCIATION_ASSIGN);
    //断开读取外围对象(核心对象/hash映射键)
    NSString *associatedOutObjectClose = (NSString *)objc_getAssociatedObject(array,&overviewKey);
    NSLog(@"associatedOutObjectClose=%@",associatedOutObjectClose);

    //断开核心对象array涉及的所有关联体系(array不再持有任何外围对象(array恢复至原始状态))
    objc_removeAssociatedObjects(array);


}


- (void)associatedObjectsMethodNew {
    NSArray *array = [[NSArray alloc] initWithObjects:@"1", @"2", @"3", nil];
    //关联关键字
    static char overviewKey;
    //正式搭建某个关联体系
    objc_setAssociatedObject(array, &overviewKey, @"你好吗中国", OBJC_ASSOCIATION_RETAIN);

    //读取外围对象
    NSString *associatedOutObject = (NSString *)objc_getAssociatedObject(array,&overviewKey);

    NSLog(@"associatedOutObject=%@",associatedOutObject);


    objc_setAssociatedObject(array,&overviewKey,nil, OBJC_ASSOCIATION_ASSIGN);
    //断开读取外围对象
    NSString *associatedOutObjectClose = (NSString *)objc_getAssociatedObject(array,&overviewKey);
    NSLog(@"associatedOutObjectClose=%@",associatedOutObjectClose);

    objc_removeAssociatedObjects(array);


}

//base64字符串转PDF文件
- (void)pdfFromBase64String:(NSString *)base64 {
    NSData *EncryptData = [self dataFromBase64String:base64];
    [self pdfFromData:EncryptData];
}

//base64字符串转NSData数据
- (NSData *)dataFromBase64String:(NSString *)base64 {
    NSData *EncryptData;
    if ([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0) {
        EncryptData = [[NSData alloc] initWithBase64EncodedString:base64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    }else{
        EncryptData = [[NSData alloc] initWithBase64Encoding:base64];
    }
    return EncryptData;
}

//base64字符串转普通字符串
- (NSString *)textStringFromBase64String:(NSString *)base64 {
    NSData *EncryptData;
    if ([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0) {
        EncryptData = [[NSData alloc] initWithBase64EncodedString:base64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    }else{
        EncryptData = [[NSData alloc] initWithBase64Encoding:base64];
    }
    NSString *textString = [[NSString alloc] initWithData:EncryptData encoding:NSUTF8StringEncoding];
    return textString;
}


//普通字符串转base64字符串
- (NSString *)base64StringFromText:(NSString *)text {
    NSData *data = [text dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64String = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return base64String;
}

//NSData数据转PDF文件
- (void)pdfFromData:(NSData *)data {
    //查找Documents文件夹路径
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    //待存储内容
    NSString *pdfStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    //创建文件存储路径
    NSString *pathComponent = [NSString stringWithFormat:@"%@Share.pdf",[self dateTimeCurrent]];
    NSString *path = [documentsPath stringByAppendingPathComponent:pathComponent];
    NSLog(@"path=%@",path);

    //待存储内容写入文件
    if ([[[UIDevice currentDevice] systemVersion] floatValue]>=2.0) {
        [pdfStr writeToFile:[path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] atomically:YES encoding:NSUTF8StringEncoding error:NULL];
    }else{
        [pdfStr writeToFile:[path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] atomically:YES];
    }

}

- (NSString *)dateTimeCurrent {
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    //HH:24制;hh:12制
    [dateFormat setDateFormat:@"yyyyMMddHHmmss"];
    NSString * dateStr = [dateFormat stringFromDate:date];
    return dateStr;
}

- (void)xibConstraints {
//    NSArray *elementsLt = [[NSBundle mainBundle] loadNibNamed:@"CustomTestCanvas" owner:self options:nil];
//
//
//    XibTestView *elementDirectXib = [XibTestView new];
//    if (elementsLt.count>0) {
//        //(获取)最下面层视图(元素数目)
//        elementDirectXib = [elementsLt firstObject];
//    }
//    [self.view addSubview:elementDirectXib];
//    elementDirectXib.frame = CGRectMake(0, 0, kScreenW, kScreenH);
//
//    self.oneL.text = @"王王王王王王王王王王随便随便随便随便随便随便随便随便随便";
//    self.twoL.text = @"不住";
//    if (![self.threeBtn isDescendantOfView:self.view]) {
//        [self.view addSubview:self.threeBtn];
//    }

    //view1可以待布局元件也可以为参考元件
    //view2可以参考元件也可以为待布局元件
    //事件函数计算公式:
    //view1.attr1 <relation> view2.attr2 * multiplier + constant

    //view1：约束线左(上)边端的元件(左(上)元件1)
    //attr1：指定view1约束线相关的轴线属性attr1(左(上)元件1的轴线属性attr1)

    //relation:view1元件/view2元件相应轴线属性的关系(位置方面关系)

    //view2：约束线右(下)边端的元件(右(下)元件2)
    //attr2：指定view2约束线相关的轴线属性attr2(右(下)元件2的轴线属性attr2)
    //multiplier：乘数因子(相对右(下)元件view2的长度方面属性涉及到的乘数因子multiplier)(尺寸方面乘数因子)
    //c：相对右(下)元件view2的属性进行叠加的浮点常数据constant(移位效果)
    //注意:如果相关的约束线不需要右(下)view2元件，则将view2参数设为nil，attr2参数设为NSLayoutAttributeNotAnAttribute

//    //关键点1
//    //待布局元件(禁用AutoresizingMask(约束线(指令)生效))
//    [self.threeBtn setTranslatesAutoresizingMaskIntoConstraints:NO];
//
//    //关键点2
//    NSLayoutConstraint *leftConstraint;
//    //构建约束线(指令)
//    leftConstraint = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.threeBtn attribute:NSLayoutAttributeLeft multiplier:1 constant:-15];
//    //关键点3
//    //已存在的约束线(指令)绑定视图(有效化)
//    [self.view addConstraint:leftConstraint];
//
//    NSLayoutConstraint *topConstraint;
//    //构建约束线
//    topConstraint = [NSLayoutConstraint constraintWithItem:self.threeBtn attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:-100];
//    //已存在的约束线绑定视图(有效化)
//    [self.view addConstraint:topConstraint];

//    NSLog(@"frame=%@==%@",NSStringFromCGRect(elementDirectXib.frame),NSStringFromCGRect(self.view.frame));
//    elementDirectXib.frame = CGRectMake(0, 0, kScreenW, 0.8*kScreenH);


    //    XibTestViewTwo *elementDirectXibTwo = [[[NSBundle mainBundle] loadNibNamed:@"XibTestViewTwo" owner:self options:nil] firstObject];

//    XibTestViewTwo *elementDirectXibTwo = [XibTestViewTwo shareInstance];
//    [self.view addSubview:elementDirectXibTwo];
//    elementDirectXibTwo.frame = CGRectMake(0, 8, kScreenW, kScreenH*0.7);
//    [elementDirectXibTwo sizeToFit];
//    [elementDirectXibTwo setNeedsDisplay];
////    elementDirectXibTwo.contentMode = UIViewContentModeRedraw;
//
//    elementDirectXibTwo.frame = CGRectMake(0, 103, kScreenW, kScreenH*0.7);
//    elementDirectXibTwo.BtnClick = ^{
//        ResponderChainViewController *vc = [ResponderChainViewController new];
//        vc.view.backgroundColor = [UIColor whiteColor];
//        [self presentViewController:vc animated:YES completion:nil];
//    };


    SRCBZYBAlertView *elementDirectXibTwo = [SRCBZYBAlertView shareInstance];
    [self.view addSubview:elementDirectXibTwo];
    elementDirectXibTwo.frame = CGRectMake(0, 0, kScreenW, kScreenH);
    elementDirectXibTwo.ElementClick = ^(NSInteger index, UIButton *btn) {
        if (index == 0) {//再等等

        } else if (index == 1) {//前往

        } else if (index == 2) {//不再提示

        }
    };



//    [elementDirectXibTwo layoutIfNeeded];
//    [elementDirectXibTwo layoutSubviews];

//    elementDirectXibTwo.frame = CGRectMake(0, 8, kScreenW, kScreenH*0.5);
//    [elementDirectXibTwo layoutIfNeeded];

//    [self.view addSubview:self.containerView];
//    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.view.mas_left);
//        make.top.mas_equalTo(self.view.mas_top).offset(40);
//        make.right.mas_equalTo(self.view.mas_right);
//        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-40);
//    }];
//
//    [self.containerView.contentView addSubview:self.contentV];
//    [self.contentV mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.containerView.contentView.mas_left);
//        make.top.mas_equalTo(self.containerView.contentView.mas_top);
//        make.width.mas_equalTo(self.containerView.mas_width);
//
//        make.right.mas_equalTo(self.containerView.contentView.mas_right);
//        make.bottom.mas_equalTo(self.containerView.contentView.mas_bottom);
//    }];
//
//    XibTestViewTwo *elementDirectXibTwo = [XibTestViewTwo shareInstance];
//
//    [self.contentV addSubview:elementDirectXibTwo];
//    [elementDirectXibTwo mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.contentV.mas_left);
//        make.top.mas_equalTo(self.contentV.mas_top);
//        make.width.mas_equalTo(self.contentV.mas_width);
//        make.height.mas_equalTo(@(kScreenH*2));
//
//        make.bottom.mas_equalTo(self.contentV.mas_bottom);
//
//    }];
//    [elementDirectXibTwo layoutIfNeeded];





}


@end
