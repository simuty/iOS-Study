//
//  ViewController.m
//  iOSBlur
//
//  Created by HHW on 16/8/11.
//  Copyright © 2016年 HHW. All rights reserved.
//

#import "ViewController.h"

#import <CoreImage/CoreImage.h>
#import <Accelerate/Accelerate.h>
#import "UIImage+ImageEffects.h"
#import "FXBlurView.h"
#import "GPUImage.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor grayColor];
}

//恢复原状
- (IBAction)resetImageView:(id)sender {
    
    
    UIImage *sourceImage = [UIImage imageNamed:@"test"];
    self.imageView.image = sourceImage;
    
}

//

/**
 *第一种: CoreImage使用, 
 *
 *  优点: 模糊效果较好，模糊程度的可调范围很大，可以根据实际的需求随意调试。
 *   
 *  缺点: 耗时
 *
 *  需要导入: #import <CoreImage/CoreImage.h>
 
 */

- (IBAction)useCoreImage:(id)sender {

    ViewController* __block  blockSelf = self;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        UIImage *sourceImage = [UIImage imageNamed:@"test"];
        
        CIContext *context = [CIContext contextWithOptions:nil];
        //CIImage
        CIImage *ciImage = [[CIImage alloc] initWithImage:sourceImage];
        //过滤器
        CIFilter *blurFilter = [CIFilter filterWithName:@"CIGaussianBlur"];
        //将图片输入到滤镜中
        [blurFilter setValue:ciImage forKey:kCIInputImageKey];
        //设置模糊程度
        [blurFilter setValue:@(5) forKey:@"inputRadius"];
        
        NSLog(@"查看blurFilter的属性--- %@",blurFilter.attributes);
        
        //将处理之后的图片输出
        CIImage *outCIImage = [blurFilter valueForKey:kCIOutputImageKey];
        
        /** 获取CGImage句柄
         *  createCGImage: 处理过的CIImage
         *  fromRect: 如果从处理过的图片获取frame会比原图小, 因此在此需要设置为原始的CIImage.frame
         */
        CGImageRef outCGImageRef = [context createCGImage:outCIImage fromRect:[ciImage extent]];
        //获取到最终图片
        UIImage *resultImage = [UIImage imageWithCGImage:outCGImageRef];
        //释放句柄
        CGImageRelease(outCGImageRef);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            blockSelf.imageView.image = resultImage;
        });
        
    });

}




/**
 *  UIBlurEffect
 *
 *  @param sender UIVisualEffectView
 */
- (IBAction)useEffect:(id)sender {
   
    self.imageView.image = [UIImage imageNamed:@"2"];
    
    // Blur effect 模糊效果
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    
    UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    blurEffectView.frame = CGRectMake(50, 30, self.imageView.frame.size.width - 100, self.imageView.frame.size.height - 60);

    [self.imageView addSubview:blurEffectView];
    
    // Vibrancy effect 生动效果<根据背景图实时调整文字颜色>
    UIVibrancyEffect *vibrancyEffect = [UIVibrancyEffect effectForBlurEffect:blurEffect];
    UIVisualEffectView *vibrancyEffectView = [[UIVisualEffectView alloc] initWithEffect:vibrancyEffect];
    vibrancyEffectView.frame = CGRectMake(50, 30, self.imageView.frame.size.width - 100, self.imageView.frame.size.height - 60);
    // 添加vibrancy view 到 blur view的contentView上
    [blurEffectView.contentView addSubview:vibrancyEffectView];
    
    
    // 效果字体
    UILabel *label = [[UILabel alloc] init];
    label.text = @"UIVibrancyEffect";
    label.font = [UIFont systemFontOfSize:28.0f];
    [label sizeToFit];
    label.frame = CGRectMake(10, 10, 200, 60);
    // 添加label到the vibrancy view的contentView上
    [vibrancyEffectView.contentView addSubview:label];
    
    
}

//苹果推出的框架
- (IBAction)useEffects:(id)sender {
    //模糊区域
    self.imageView.image = [[UIImage imageNamed:@"test"] blurImageAtFrame:CGRectMake(0.0, 0.0, 155.0*2 , 235.0*4.0)];
    //全部模糊
    //self.imageView.image = [[UIImage imageNamed:@"test"] blurImage];
   // self.imageView.image = [[UIImage imageNamed:@"test"] blurImageWithMask:[UIImage imageNamed:@"2"]];
}

/**
 *  FXBlurView
 *
 */

- (IBAction)useFXBlurView:(id)sender {
    
    FXBlurView *fxView = [[FXBlurView alloc] initWithFrame:CGRectMake(0, 0, self.imageView.frame.size.width, self.imageView.frame.size.height)];
    //动态
    fxView.dynamic = NO;
    //模糊范围
    fxView.blurRadius = 10;
    //背景色
    fxView.tintColor = [UIColor clearColor];
    [self.imageView addSubview:fxView];
    
}

/**
 *  GPUImage简单使用
 *
 *  @param sender
 */
- (IBAction)useGPUImage:(id)sender {
    

    ViewController* __block  blockSelf = self;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
       
        // 高斯模糊
        GPUImageGaussianBlurFilter * blurFilter = [[GPUImageGaussianBlurFilter alloc] init];
        blurFilter.blurRadiusInPixels = 10;
        UIImage *blurImage = [blurFilter imageByFilteringImage:[UIImage imageNamed:@"test"]];
    
        dispatch_async(dispatch_get_main_queue(), ^{
            blockSelf.imageView.image = blurImage;
        });
    });
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
