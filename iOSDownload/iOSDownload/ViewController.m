//
//  ViewController.m
//  iOSDownload
//
//  Created by BWF-HHW on 16/8/17.
//  Copyright © 2016年 HHW. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

#define kCurrentSession       @"Current Session"
#define kBackgroundSession    @"Background Session"
#define kBackgroundSessionID @"com.stu.DownloadTask.BackgroundSession"
#define WeakSelf __weak typeof(self) weakSelf = self;


@interface ViewController ()<NSURLSessionDownloadDelegate>

// 当前会话
@property (strong, nonatomic)  NSURLSession *currentSession;

// 后台会话
@property (strong, nonatomic) NSURLSession *backgroundSession;


//取消下载
@property (nonatomic, strong) NSURLSessionDownloadTask *cancelDownloadTask;
//可以恢复的下载
@property (nonatomic, strong) NSURLSessionDownloadTask *resumableDownloadTask;
//后台下载
@property (nonatomic, strong) NSURLSessionDownloadTask *backDownloadTask;


//可以恢复下载的数据
@property (nonatomic, strong) NSData *resumableData;
@property (nonatomic, assign) BOOL judgeSuspend;

//按钮与视图
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UIButton *startDownloadBtn;
@property (strong, nonatomic) IBOutlet UIButton *backDownloadBtn;
@property (strong, nonatomic) IBOutlet UIButton *suspendBtn;
@property (strong, nonatomic) IBOutlet UIButton *cancalDownloadBtn;
@property (strong, nonatomic) IBOutlet UIProgressView *progressView;




@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.judgeSuspend = NO;
}
#pragma mark 开始下载
- (IBAction)startDownload:(id)sender {

    if (!self.cancelDownloadTask) {
        
        self.imageView.image = nil;
        NSString *imageURLStr = @"http://upload-images.jianshu.io/upload_images/326255-2834f592d7890aa6.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240";
        //创建网络请求
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:imageURLStr]];
        //将当前session中创建下载取消的任务
        self.cancelDownloadTask = [self.currentSession downloadTaskWithRequest:request];
        //保证下载按钮只点击一次
        [self setDownloadButtonsWithEnabled:NO];
        //开始
        [self.cancelDownloadTask resume];
    }

}

#pragma mark 取消下载任务
- (IBAction)cancelDownload:(id)sender {
    if (self.cancelDownloadTask) {
        [self.cancelDownloadTask cancel];
        self.cancelDownloadTask = nil;
    }else if (self.resumableDownloadTask) {
        [self.resumableDownloadTask cancelByProducingResumeData:^(NSData *resumeData) {
            // 如果是可恢复的下载任务，应该先将数据保存到partialData中，注意在这里不要调用cancel方法
            self.resumableData = resumeData;
            self.resumableDownloadTask = nil;
        }];
    }else if (self.backDownloadTask) {
        [self.backDownloadTask cancel];
        self.backDownloadTask = nil;
    }
    self.progressView.progress = 0.0f;
    self.imageView.image = nil;
}



#pragma mark 暂停/继续下载
- (IBAction)suspendDownload:(id)sender {
    
    //在此对该按钮做判断
    if (self.judgeSuspend) {
        [self.suspendBtn setTitle:@"继续下载" forState:UIControlStateNormal];
        self.judgeSuspend = NO;
        [self suspendDown];
    }else{
         [self.suspendBtn setTitle:@"暂停下载" forState:UIControlStateNormal];
        self.judgeSuspend = YES;
        [self startResumableDown];
    }
}

//继续下载
- (void)startResumableDown{

    if (!self.resumableDownloadTask) {
        // 如果是之前被暂停的任务，就从已经保存的数据恢复下载
        if (self.resumableData) {
            self.resumableDownloadTask = [self.currentSession downloadTaskWithResumeData:self.resumableData];
        }else {
            // 否则创建下载任务
            NSString *imageURLStr = @"http://dlsw.baidu.com/sw-search-sp/soft/9d/25765/sogou_mac_32c_V3.2.0.1437101586.dmg";
            NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:imageURLStr]];
            self.resumableDownloadTask = [self.currentSession downloadTaskWithRequest:request];
        }
        //关闭所有的按钮的相应
        [self setDownloadButtonsWithEnabled:NO];
        self.suspendBtn.enabled   = YES;
        self.imageView.image = nil;
        [self.resumableDownloadTask resume];
    }

}


//暂停下载
- (void)suspendDown{

    if (self.resumableDownloadTask) {
        [self.resumableDownloadTask cancelByProducingResumeData:^(NSData *resumeData) {
            // 如果是可恢复的下载任务，应该先将数据保存到partialData中，注意在这里不要调用cancel方法
            self.resumableData = resumeData;
            self.resumableDownloadTask = nil;
        }];
    }

}


#pragma mark 后台下载
- (IBAction)backDownload:(id)sender {
        NSString *imageURLStr = @"http://dlsw.baidu.com/sw-search-sp/soft/9d/25765/sogou_mac_32c_V3.2.0.1437101586.dmg";
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:imageURLStr]];
        self.backDownloadTask = [self.backgroundSession downloadTaskWithRequest:request];
        [self setDownloadButtonsWithEnabled:NO];
        [self.backDownloadTask resume];
}






//一些方法
- (void)setDownloadButtonsWithEnabled:(BOOL)enabled{
    self.startDownloadBtn.enabled = enabled;
    self.suspendBtn.enabled   = enabled;
    self.backDownloadBtn.enabled  = enabled;
}



#pragma mark 下载的代理

/* 执行下载任务时有数据写入 */
- (void)URLSession:(NSURLSession *)session
      downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten // 每次写入的data字节数
 totalBytesWritten:(int64_t)totalBytesWritten // 当前一共写入的data字节数
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite // 期望收到的所有data字节数
{
    
    // 计算当前下载进度并更新视图
    float downloadProgress = totalBytesWritten / (float)totalBytesExpectedToWrite;
    NSLog(@"----%f", downloadProgress);

    NSLog(@"----%@", [NSThread currentThread]);

    
    WeakSelf;
    dispatch_async(dispatch_get_main_queue(), ^{
        /* 根据下载进度更新视图 */
        weakSelf.progressView.progress = downloadProgress;
    });
    
}


/* 从fileOffset位移处恢复下载任务 */
- (void)URLSession:(NSURLSession *)session
      downloadTask:(NSURLSessionDownloadTask *)downloadTask
 didResumeAtOffset:(int64_t)fileOffset
expectedTotalBytes:(int64_t)expectedTotalBytes {
    NSLog(@"NSURLSessionDownloadDelegate: Resume download at %lld", fileOffset);
}



/* 完成下载任务，只有下载成功才调用该方法 */
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location {
    
    NSLog(@"NSURLSessionDownloadDelegate: Finish downloading");
    NSLog(@"----%@", [NSThread currentThread]);

    // 1.将下载成功后的文件<在tmp目录下>移动到目标路径
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *fileArray = [fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    NSURL *destinationPath = [fileArray.firstObject URLByAppendingPathComponent:[location lastPathComponent]];
    
    
    //在此有个下载文件后缀的问题
    
    NSLog(@"----路径--%@/n---%@", destinationPath.path, location);
    if ([fileManager fileExistsAtPath:[destinationPath path] isDirectory:NULL]) {
        [fileManager removeItemAtURL:destinationPath error:NULL];
    }
    
    //2将下载默认的路径移植到指定的路径
    NSError *error = nil;
    if ([fileManager moveItemAtURL:location toURL:destinationPath error:&error]) {
        self.progressView.progress = 1.0;
        //刷新视图，显示下载后的图片
        UIImage *image = [UIImage imageWithContentsOfFile:[destinationPath path]];
        WeakSelf;
        //回主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.imageView.image = image;
        });
    }
    
    [self setDownloadButtonsWithEnabled:YES];

    // 3.取消已经完成的下载任务
    if (downloadTask == self.cancelDownloadTask) {
        self.cancelDownloadTask = nil;
    }else if (downloadTask == self.resumableDownloadTask) {
        self.resumableDownloadTask = nil;
        self.resumableData = nil;
    }else if (session == self.backgroundSession) {
        self.backDownloadTask = nil;
        AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
        if (appDelegate.backgroundURLSessionCompletionHandler) {
            // 执行回调代码块
            void (^handler)() = appDelegate.backgroundURLSessionCompletionHandler;
            appDelegate.backgroundURLSessionCompletionHandler = nil;
            handler();
        }
    }
}

/* 完成下载任务，无论下载成功还是失败都调用该方法 */
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    
    NSLog(@"=====%@", [NSThread currentThread]);
    //恢复按钮的点击效果
   [self setDownloadButtonsWithEnabled:YES];

    if (error) {
        NSLog(@"下载失败：%@", error);
        self.progressView.progress = 0.0;
        self.imageView.image = nil;
    }
}




#pragma  mark 懒加载

- (NSURLSession *)currentSession{
    
    if (!_currentSession) {
        NSURLSessionConfiguration *defaultConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
        _currentSession = [NSURLSession sessionWithConfiguration:defaultConfig delegate:self delegateQueue:nil];
        _currentSession.sessionDescription = @"Current Session";
        
    }
    
    return _currentSession;
}


/* 创建一个后台session单例 */
- (NSURLSession *)backgroundSession {
    static NSURLSession *backgroundSess = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        NSURLSessionConfiguration *config = [NSURLSessionConfiguration backgroundSessionConfiguration:kBackgroundSessionID];
        backgroundSess = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
        backgroundSess.sessionDescription = kBackgroundSession;
    });
    
    return backgroundSess;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
