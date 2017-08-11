//
//  ViewController.m
//  RuntimeDemo
//
//  Created by BWF-HHW on 16/8/4.
//  Copyright © 2016年 HHW. All rights reserved.
//

#import "ViewController.h"
#import "NSObject+Model.h"

#import "Model.h"
#import <objc/runtime.h>


@interface ViewController ()

@property (nonatomic, strong) Model *model;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    self.model = [[Model alloc] init];

}

//运行时创建类并添加方法
- (IBAction)runingCreateClass:(id)sender {
    
    //运行时创建NSError的子类, 使用objc_allocateClassPair开辟空间
    Class newClass = objc_allocateClassPair([NSError class], "RuntimeErrorSubclass", 0);
    //运行时添加方法
    class_addMethod(newClass, @selector(report), (IMP)ReportFunction, "v@:");
    //使用objc_registerClassPair注册你创建的这个类
    objc_registerClassPair(newClass);
    
    //初始化刚创建的newClass的实例对象
    id instanceOfNewClass = [[newClass alloc]initWithDomain:@"some Domain" code:0 userInfo:nil];
    //利用实例方法调用刚才添加的方法
    [instanceOfNewClass performSelector:@selector(report)];
    
    
}



void ReportFunction(id self, SEL _cmd)
{
    NSLog(@"This object is %p.",self);
    NSLog(@"Class is %@, and super is %@.",[self class],[self superclass]);
    Class currentClass = [self class];
    for( int i = 1; i < 5; ++i )
    {
        NSLog(@"Following the isa pointer %d times gives %p",i,currentClass);
        currentClass = object_getClass(currentClass);
    }
    NSLog(@"NSObject's class is %p", [NSObject class]);
    NSLog(@"NSObject's meta class is %p",object_getClass([NSObject class]));
}





//获取所有成员变量的信息
- (IBAction)getAllVar:(id)sender {
    
    unsigned int count = 0;
    //获取类的一个包含所有属性变量的列表，IVar是runtime声明的一个宏，是实例变量的意思.
    Ivar *allVariables = class_copyIvarList([self.model class], &count);
    
    for (int i = 0; i < count; i++) {
        Ivar ivar = allVariables[i];
        //属性名
        const char *varName = ivar_getName(ivar);
        //类型
        const char *varType = ivar_getTypeEncoding(ivar);
        NSLog(@"(Name: %s) ----- (Type:%s)",varName,varType);
    }
    
    
    
}

//获取所有的方法
- (IBAction)getAllMethod:(id)sender {
    
    
    unsigned int count;
    
    //获取方法列表，所有方法都将被罗列,
    Method *allMethods = class_copyMethodList([self.model class], &count);
    
    for (int i = 0; i < count; i++) {
        Method method = allMethods[i];
        //获取SEL：SEL类型,即获取方法选择器@selector()
        SEL sel = method_getName(method);
        const char *methodName = sel_getName(sel);
        NSLog(@"方法包含--%s", methodName);
        
    }
    
    
    
}

//改变私有变量的信息
- (IBAction)changePrivateVar:(id)sender {
    
    
    NSLog(@"原先的person：%@", self.model);

    unsigned int count = 0;
    Ivar *allList = class_copyIvarList([self.model class], &count);
    Ivar ivar = allList[1];
    //实例变量的Ivar已经知道, 所以我们使用object_setIvar, 因为打印结果第二个是私有变量
    object_setIvar(self.model, ivar, @"women");
    
    NSLog(@"改变之后的person：%@", self.model);
}

//添加新的属性
- (IBAction)addNewVar:(id)sender {
    
    
    /**
     *  第一步创建类的category<cmd+n --> Source-->选择OC文件>
     *  第二步 重写setter getter方法
     */
    
    self.model.height = 12;           //给新属性height赋值
    NSLog(@"%f", self.model.height); //访问新属性值
    
    
}


//添加新的方法, 可以先获取所有的方法, 再添加, 然后在打印所有的方法查看结果
- (IBAction)addNewMethod:(id)sender {

    /* 动态添加方法：
     第一个参数表示Class cls 类型；
     第二个参数表示待调用的方法名称；
     第三个参数(IMP)myAddingFunction，IMP一个函数指针，这里表示指定具体实现方法myAddingFunction；
     第四个参数表方法的参数，0代表没有参数；
     */
    class_addMethod([self.model class], @selector(NewMethod), (IMP)myAddingFunction, 0);
    
    //调用 【如果使用[per method]方法！(在ARC下会报no visible @interface 错误)】
    [self.model performSelector:@selector(NewMethod)];

}


//具体的实现（方法的内部都默认包含两个参数Class类和SEL方法，被称为隐式参数。）
int myAddingFunction(id self, SEL _cmd)
{
    NSLog(@"已新增方法:NewMethod");
    return 1;
}



//交换方法
- (IBAction)exchangeMethod:(id)sender {
    
    Method method1 = class_getInstanceMethod([self.model class], @selector(func1));
    Method method2 = class_getInstanceMethod([self.model class], @selector(func2));
    method_exchangeImplementations(method1, method2);
    [self.model func1];  //输出交换后的效果，需要对比的可以尝试下交换前运行func1；
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
