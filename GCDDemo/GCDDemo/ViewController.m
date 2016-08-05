//
//  ViewController.m
//  GCDDemo
//
//  Created by HHW on 16/5/13.
//  Copyright © 2016年 HHW. All rights reserved.
//

#import "ViewController.h"
#import "Header.h"


@interface ViewController ()

@end

//第一: 核心概念
//任务：执行什么操作
//队列：用来存放任务


//第二: 执行的步骤

//1. 定制任务
//2. 将任务添加到队列中
//2.1 并发队列（Concurrent Dispatch Queue）: 可以让多个任务并发（同时）执行（自动开启多个线程同时执行任务）, 前提是在dispatch_async异步函数下执行
//2.2 串行队列(Serial Dispatch Queue）:一个任务执行完毕后，再执行下一个任务

//3. 并发和串行区别：任务的执行方式不同



//第三: 如何执行任务
//1. 同步函数dispatch_sync  < synchronous>: 不具备开启新线程的能力
//
//2. 异步函数dispatch_async <asynchronous>: 具备开启新线程的能力
//
//3. 同步和异步区别：能不能开启新的线程
//


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    
    NSLog(@"0000000000000");
    
    
    
    
    
    
#pragma asynchronous
    //设置优先级的queue
    // [self stu_dispatch_set_target_queue];
    //定时在多久后执行任务
    // [self stu_disparch_after];
    //组操作
    // [self stu_dispatch_group];
    //dispatch_barrier_async函数用于等待队列中其他任务完成。
    //[self stu_dispatch_barrier_async];
    
#pragma synchronous
    //死锁
    //[self stu_sync];
    //dispatch_apply在执行完毕后才会返回
   // [self stu_dispatch_apply];
    //dispatch_apply_sync 结合
    //[self stu_dispatch_apply_sync];
    
#pragma Dispatch Semaphore
    //此种方法会奔溃, 原因看方法中的描述
    //[self stu_dispatch_semaphore];
    //对比上个方法, 结合信号量处理并发读取或更新数据
    //[self stu_dispatch_semaphore_sample];


#pragma dispatch_once
    //保证只是创建一次
    //[self stu_dispatch_once];
    
    
 //   [self stu_dispatchIO];

}






#pragma mark - dispatch_set_target_queue
//dispatch_set_target_queue函数的第一个参数是要设置优先级的队列，第二个参数是一个全局的dispatch队列，它会被作为目标队列。
- (void)stu_dispatch_set_target_queue {
    
   // 使用dispatch_queue_create函数创建串行队列, 第一个参数反向全称域名: com.example.gcd.
    
    
#warning 第二个参数
    //如果要创建一个串行dispatch队列，就将其设置成NULL。
    //如果要创建一个并行dispatch队列，就设置成DISPATCH_QUEUE_CONCURRENT
    dispatch_queue_t serialQueue = dispatch_queue_create("com.example.gcd.serialqueue", DISPATCH_QUEUE_SERIAL);
    
    dispatch_queue_t firstQueue = dispatch_queue_create("com.example.gcd.firstqueue", DISPATCH_QUEUE_SERIAL);
    
    dispatch_queue_t secondQueue = dispatch_queue_create("com.example.gcd.secondqueue", DISPATCH_QUEUE_CONCURRENT);
    
    // 第一个参数为要设置优先级的queue,第二个参数是参照物，既将第一个queue的优先级和第二个queue的优先级设置一样。
    dispatch_set_target_queue(firstQueue, serialQueue);
    dispatch_set_target_queue(secondQueue, serialQueue);
    
    dispatch_async(firstQueue, ^{
        NSLog(@"1");
        [NSThread sleepForTimeInterval:3.f];
    });
    
    dispatch_async(serialQueue, ^{
        NSLog(@"2");
        [NSThread sleepForTimeInterval:2.f];
    });
    
    dispatch_async(secondQueue, ^{
        NSLog(@"3");
        [NSThread sleepForTimeInterval:1.f];
    });
    
    NSLog(@"当你有些任务不想它们同时运行而又不得不将它们添加到不同的串行队列中时，就可以避免它们同时运行。(虽然，实际上我也不知道什么情况下会有这样的需求。)");
    
}

#pragma dispatch_after  dispatch_after用于在队列中定时执行任务。当你想在一段时间后执行一个任务，那么就可以用这个函数。
//3秒过后，指定的block会被添加到主线程队列上。
- (void)stu_disparch_after{

    
    //”ull”代表”unsigned long long”类型
    //dispatch_time的第一个参数是指定的起始时间，第二个参数是以纳秒为单位的一个时间间隔。
    // NSEC_PER_SEC 纳秒
    // NSEC_PER_MSEC 毫秒
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 3ull * NSEC_PER_SEC);
    //dispatch_after函数并不会在指定的时间后立即执行任务，时间到后，它只将任务加入到队列上。
    dispatch_after(time, dispatch_get_main_queue(), ^{
        NSLog(@"已经过了至少3秒, 才打印出此结果");
    });
    
    NSLog(@"主线程队列是在RunLoop上执行的，因此，假如RunLoop每1/60秒执行一次任务，那么上面添加的block会在3秒~3+1/60秒后被执行。如果主线程队列上加了很多任务，或者主线程延迟了，时间可能更晚。所以，将dispatch_after作为一个精确的定时器使用是有问题的。如果你只是想粗略的延迟一下任务，这个函数还是很有用的。");

}




#pragma dispatch Group 有时你可能需要等dispatch队列中的所有任务完成了再执行另外一个任务。当所有任务都在一个串行队列里面的时候，你只需要将最后一个任务加到队列最后就可以了。但如果你在使用并行队列的时候或者面对多个队列的时候，看起来就没那么简单了。

- (void)stu_dispatch_group {

    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //创建组
    dispatch_group_t group = dispatch_group_create();
    //dispatch_group_async函数将block加到指定的队列上,
    dispatch_group_async(group, queue, ^{NSLog(@"0");});
    // 当一个block和dispatch group关联起来后，block也就会通过dispatch_retain函数获得dispatch group的所有权。当block执行完毕后，也会通过dispatch_release函数释放掉对group的所有权。你不需要去关心block和group是如何关联起来的。
    dispatch_group_async(group, queue, ^{NSLog(@"1");});
    dispatch_group_async(group, queue, ^{NSLog(@"2");});
    
#pragma 第一种等待group完成后执行的方法: 建议还是用dispatch_group_notify函数好些，这样你的代码可以更简洁。
    
    //dispatch_group_notify函数将一个block加到了一个dispatch队列上。这个block会在group中的所有任务完成后被执行。
    dispatch_group_notify(group,dispatch_get_main_queue(), ^{NSLog(@"结束, 每次运行所执行的顺序都不一样");
    });
    
#pragma 第一种等待group完成后执行的方法:
#pragma 使用dispatch_group_wait函数, DISPATCH_TIME_FOREVER表示永远等待直到group执行结束, 举一反三可以利用long result = dispatch_group_wait(group, DISPATCH_TIME_NOW);来判断当前group的执行状态
    
//    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, DISPATCH_TIME_FOREVER);
//    long result = dispatch_group_wait(group, time);
//    if (result == 0){
//        NSLog(@"group 已经执行完毕");
//    }else{
//        NSLog(@"group 尚未执行完毕");
//    }
    
    

}



#warning 除了采用串行队列以外, 如何确保在更新数据或读取数据的操作时避免数据冲突 ? 就轮到dispatch_barrier_async函数登场了 ! 尽情的使用并发队列和dispatch_barrier_async函数吧。
#warning dispatch_barrier_async函数用于等待队列中其他任务完成。


- (void)stu_dispatch_barrier_async{

    
#warning 以下的执行顺序保证<写入数据>永远在取数据1和2后, 在3和4前
    
    dispatch_queue_t dataQueue = dispatch_queue_create("com.HHW.dataqueue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(dataQueue, ^{
        [NSThread sleepForTimeInterval:1.f];
        NSLog(@"取数据 1---线程为---%@", [NSThread currentThread]);
    });
    dispatch_async(dataQueue, ^{
        NSLog(@"取数据2---线程为---%@", [NSThread currentThread]);
    });
    //等待前面的都完成，在执行barrier后面的
    dispatch_barrier_async(dataQueue, ^{
        NSLog(@"写入数据");
    });
    dispatch_async(dataQueue, ^{
        [NSThread sleepForTimeInterval:1.f];
        NSLog(@"取数据3---线程为---%@", [NSThread currentThread]);
    });
    dispatch_async(dataQueue, ^{
        NSLog(@"取数据4---线程为---%@", [NSThread currentThread]);
    });

}


- (void)stu_sync{

#warning 死锁
    
#warning 第一种死锁:  一个block被加到了主线程队列上，但同时，它又会等待block完成后才能继续。因为这段代码是运行在主线程上面的，被加到主线程队列上的这个block永远也无法被执行。
//    dispatch_queue_t queue = dispatch_get_main_queue();
//    dispatch_sync(queue, ^{
//        NSLog(@"死锁?");
//    });
    
#warning 第二种死锁: dispatch_async添加block后，虽然会立即返回，但是因为dispatch_async添加的这个block是加到主线程队列上的，而后面dispatch_sync这个函数添加的block也是加到主线程队列上的，也会造成死锁。
    
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_async(queue, ^{
        dispatch_sync(queue, ^{
            NSLog(@"死锁?");
        });
    });

}






// dispatch_apply: dispatch_sync函数以及dispatch group有点关系, 都是等待任务完成后
// 三个参数, iterations  执行的次数, queue 提交到的队列, block 执行的任务
- (void)stu_dispatch_apply {
    
    
    /*------------------------创建三种形式---------------------------------*/
    dispatch_queue_t asyncQueue = dispatch_queue_create("com.example.gcd.stu_dispatch_apply", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_queue_t syncQueue = dispatch_queue_create("com.example.gcd.stu_dispatch_apply", NULL);
    
    //获得全局并发队列
    dispatch_queue_t queue =
    dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);

    
    /*-----------------------串行队列是有序的----------------------------------*/

    
    //串行队列是有序的
    dispatch_apply(5, syncQueue, ^(size_t index) {
        NSLog(@"++++++ %zu", index);
    });
    
    NSLog(@"结束");
    NSLog(@"结束总会在最后执行，因为dispatch_apply函数会等待所有任务完成。");
    
    /*----------------------并发队列是无序-----------------------------------*/

    
    //并发队列是无序
    dispatch_apply(5, asyncQueue, ^(size_t index) {
        NSLog(@"----%zu", index);
    });
    
    NSLog(@"结束");
    NSLog(@"结束总会在最后执行，因为dispatch_apply函数会等待所有任务完成。");
    
    /*--------------------------全局并发队列是无序的-------------------------------*/

    //全局并发队列是无序的
    dispatch_apply(5, queue, ^(size_t index) {
        NSLog(@"=====%zu", index);
    });
    
    NSLog(@"结束");
    NSLog(@"结束总会在最后执行，因为dispatch_apply函数会等待所有任务完成。");


}

#warning 建议你将dispatch_apply和dispatch_async函数一起结合使用。

-(void)stu_dispatch_apply_sync{

    
    NSArray *array = @[@"100", @"200", @"300", @"400"];
    
    dispatch_queue_t queue =
    dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //如果你想要对一个NSArray中的所有对象进行某些操作的时候，就不需要用for循环的方式了。如下代码所示。
    dispatch_apply([array count], queue, ^(size_t index) {
        NSLog(@"%zu: %@", index, [array objectAtIndex:index]);
    });
    

    NSLog(@"-------------");
    
    /*
     * 在全局dispatch上并发执行
     */
    
    dispatch_async(queue, ^{
        /*
         * 在全局dispatch队列上，dispatch_apply会等待所有任务完成。
         */
        dispatch_apply([array count], queue, ^(size_t index) {
            /*
             * 并发地对数组中的所有对象进行一些处理
             */
            NSLog(@"%zu: %@", index, [array objectAtIndex:index]);
        });
        /*
         * dispatch_apply添加的所有任务都完成了。
         */
        
        /*
         * 在主线程dispatch队列上异步执行某些任务。
         */
        dispatch_async(dispatch_get_main_queue(), ^{
            /*
             * 这里是要在主线程队列上执行的任务。
             * 比如更新用户界面等等。
             */
            NSLog(@"结束");
        });
    });
    
    

}




#warning 对一小部分间隔时间较短的任务做并发控制的时候，Semaphore(信号量)会比串行队列或者dispatch_barrier_async更好用。

- (void)stu_dispatch_semaphore{

#warning 并发读取或更新数据时很容易造成数据冲突或者程序崩溃。你可以用串行队列或者dispatch_barrier_async函数来避免这种问题。但是有时需要在很短的时间间隔里做一些并发控制。比如，下面这个例子。在一个全局并发队列上向数组中加入数据，会有多个线程同时操作数组。由于NSMutableArrary并不支持多线程，因此当多个线程同时操作数组的时候，可能会扰乱数组中的数据。
    dispatch_queue_t queue =
    dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i = 0; i < 100000; ++i)
    {
        dispatch_async(queue, ^{
            [array addObject:[NSNumber numberWithInt:i]];
        });
    }
    
    
    
    
    
    
    
}


#warning Dispatch semaphore是一个带有一个计数器的信号量。这就是多线程编程中所谓的计数器信号量。信号量有点像一个交通信号标志，标志起来的时候你可以走，标准落下的时候你要停下来。Dispatch semaphore用计数器来模拟这种标志。计数器为0，队列暂停执行新任务并等待信号；当计数器超过0后，队列继续执行新任务，并减少计数器。
- (void)stu_dispatch_semaphore_sample{
    
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    /**
     * 创建一个信号量
     * 将初始计数器设置为1， 使得一次只能有1个线程访问NSMutableArray对象。
     */
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i = 0; i < 100000; ++i) {
        dispatch_async(queue, ^{
           
            /*
             * 等待信号量
             *
             * 一直等待，直到信号量计数器大于等于1。
             */
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
            
            
            [array addObject:[NSNumber numberWithInt:i]];
            
            dispatch_semaphore_signal(semaphore);
            
            
        });
    }
    
}



#pragma dispatch_once函数用于确保一个任务在整个程序运行过程中，只会被执行一次。

- (void)stu_dispatch_once{

    dispatch_once_t once;
    dispatch_once(&once, ^{
        /**
         *  只是被执行一次
         */
    });

}

#pragma 苹果的系统日志API(Libc-763.11 gen/asl.c)的源代码, 
#pragma 对于目前的I/O硬件来说，并发读取可能确实会比单线程读取要快。要想获得更快的读取速度，可以使用Dispatch I/O和Dispatch Data。当你使用Dispatch I/0读写文件的时候，文件会被分成某个固定大小的文件块，你可以在一个全局队列上访问它们。

- (void)stu_dispatchIO{
    
    

}



/*----------------------------------------------------*/


//Dead Lock case 1
- (void)deadLockCase1 {
    NSLog(@"1");
    //主队列的同步线程，按照FIFO的原则（先入先出），2排在3后面会等3执行完，但因为同步线程，3又要等2执行完，相互等待成为死锁。
    dispatch_sync(dispatch_get_main_queue(), ^{
        NSLog(@"2");
    });
    NSLog(@"3");
}

//Dead Lock case 2
- (void)deadLockCase2 {
    NSLog(@"1");
    //3会等2，因为2在全局并行队列里，不需要等待3，这样2执行完回到主队列，3就开始执行
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        NSLog(@"2");
    });
    NSLog(@"3");
}

//Dead Lock case 3
- (void)deadLockCase3 {
    dispatch_queue_t serialQueue = dispatch_queue_create("com.gcd.serialqueue", DISPATCH_QUEUE_SERIAL);
    NSLog(@"1");
    dispatch_async(serialQueue, ^{
        NSLog(@"2");
        //串行队列里面同步一个串行队列就会死锁
        dispatch_sync(serialQueue, ^{
            NSLog(@"3");
        });
        NSLog(@"4");
    });
    NSLog(@"5");
}

//Dead Lock case 4
- (void)deadLockCase4 {
    NSLog(@"1");
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"2");
        //将同步的串行队列放到另外一个线程就能够解决
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSLog(@"3");
        });
        NSLog(@"4");
    });
    NSLog(@"5");
}

//Dead Lock case 5
- (void)deadLockCase5 {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"1");
        //回到主线程发现死循环后面就没法执行了
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSLog(@"2");
        });
        NSLog(@"3");
    });
    NSLog(@"4");
    //死循环
    while (1) {
        //
    }
}


@end
