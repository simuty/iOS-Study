//
//  ViewController.m
//  TimeGCD
//
//  Created by BWF-HHW on 16/8/17.
//  Copyright © 2016年 HHW. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
//创建dispatch_source_t类型的timer, 用于处理定时任务
@property (nonatomic, strong) dispatch_source_t timer;
////开启专门的线程处理timer
@property (nonatomic, strong) dispatch_queue_t timerQueue;
@property (strong, nonatomic) IBOutlet UILabel *label;
@property (strong, nonatomic) IBOutlet UIButton *suspendBtn;
@property (nonatomic, assign) BOOL judgetSupendBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"主线程 %@", [NSThread currentThread]);

    self.judgetSupendBtn = YES;

}

//开始
- (IBAction)startTimer:(id)sender {
    
    __block int startTimer = 0;
    __weak typeof(self) weakself = self;
    
    //开启专门的线程处理timer
    self.timerQueue = dispatch_queue_create("TimerQueue", 0);
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, _timerQueue);
    /*----打出dispatch_s直接就出现下边的代码块了---------*/
    /**
     *  第一个参数: dispatch_source_t, Dispatch Source
     *  第二个参数: 开始时刻;
     *  第三个参数: 间隔<例子中是一秒>;
     *  第四个参数: 精度<最高精度将之设置为0>
     */
    dispatch_source_set_timer(self.timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    //函数回调
    dispatch_source_set_event_handler(self.timer, ^{
        //回主线刷新UI
        dispatch_async(dispatch_get_main_queue(), ^{
            weakself.label.text = [NSString stringWithFormat:@"%d", startTimer++];
        });
    });
    //默认的dispatch_source_t是暂停, 开始监听
    dispatch_resume(self.timer);
    /*----打出dispatch_s直接就出现上边的代码块了---------*/
    
}

//取消
- (IBAction)cancelTimer:(id)sender {
    //取消后不可恢复, 需要重新开始
    dispatch_source_cancel(self.timer);
    self.label.text = @"已取消, 需要重新开始, 该任务所在的线程也将释放, 故创建线程在开始定时器时";
}

//暂停
- (IBAction)suspendTimer:(id)sender {
    
    if (self.judgetSupendBtn) {
        dispatch_suspend(self.timer);
        [self.suspendBtn setTitle:@"继续" forState:UIControlStateNormal];
        self.judgetSupendBtn = NO;
    }else{
        self.judgetSupendBtn = YES;
        dispatch_resume(self.timer);
        [self.suspendBtn setTitle:@"暂停" forState:UIControlStateNormal];
    }
    
   
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
