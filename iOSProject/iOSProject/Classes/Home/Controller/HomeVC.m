//
//  HomeVC.m
//
//  Created by BWF-HHW on 16/4/28.
//  Copyright © 2016年 BWF. All rights reserved.
//

#import "HomeVC.h"
#import "SDCycleScrollView.h"
#import "HomeTableViewCell.h"
#import "HomeModel.h"

@interface HomeVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) SDCycleScrollView *cycleScrollView2;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, retain) NSMutableArray *dataArray;

@end



static NSString *cellId = @"Cell";

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    
    //轮播图
    [self configCycleImageView];
    //获取网络数据
    [self getNetData];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeTableViewCell" bundle:nil] forCellReuseIdentifier:cellId];
    
}



#pragma 获取网络数据
- (void)getNetData{
    
    
    
    
    
    
    [HYBNetworking getWithUrl:kHomeVCGetData refreshCache:nil params:nil progress:^(int64_t bytesRead, int64_t totalBytesRead) {
        
    } success:^(id response) {
        
        NSData *data= [NSJSONSerialization dataWithJSONObject:response options:NSJSONWritingPrettyPrinted error:nil];
        NSDictionary *dictionary =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSArray *array = [[dictionary objectForKey:@"data"] objectForKey:@"hot_activities"];
        
        //dictionary[@"data"][@"hot_activities"];
        [self handelModelWithArray:array];
        
        
    } fail:^(NSError *error) {
        
    }];
    
    
}


- (void)handelModelWithArray:(NSArray *)array{
    
    for (NSDictionary *dic in array) {
        
        HomeModel *model = [HomeModel yy_modelWithJSON:dic];
        
        [self.dataArray addObject:model];
    }
    
    [self.tableView reloadData];
    
    NSLog(@"-----%ld", self.dataArray.count);
}



#pragma tableView

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[HomeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    HomeModel *model = self.dataArray[indexPath.row];
    cell.cellNameLab.text = model.title;
    cell.cellIntroLab.text = model.title;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSLog(@"-----%ld", self.dataArray.count);
    
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  100;
}


#pragma 懒加载
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.cycleScrollView2.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - self.cycleScrollView2.frame.size.height)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}


- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}









#pragma 轮播图

- (void)configCycleImageView{
    // 情景二：采用网络图片实现
    NSArray *imagesURLStrings = @[
                                  @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
                                  @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                                  @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
                                  ];
    
    // 情景三：图片配文字
    NSArray *titles = @[@"新建交流QQ群：185534916 ",
                        @"感谢您的支持，如果下载的",
                        @"如果代码在使用过程中出现问题",
                        @"您可以发邮件到gsdios@126.com"
                        ];
    
    self.cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 180) delegate:nil placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    _cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    _cycleScrollView2.titlesGroup = titles;
    _cycleScrollView2.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
    [self.view addSubview:_cycleScrollView2];
    
    //         --- 模拟加载延迟
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _cycleScrollView2.imageURLStringsGroup = imagesURLStrings;
    });
    
    _cycleScrollView2.clickItemOperationBlock = ^(NSInteger index) {
        NSLog(@">>>>>  %ld", (long)index);
    };
    
    
}

@end
